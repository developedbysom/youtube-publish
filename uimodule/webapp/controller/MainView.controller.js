sap.ui.define(
    ["./BaseController", "sap/ui/model/json/JSONModel"],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller, JSONModel) {
        "use strict";

        return Controller.extend("som.in.totp.controller.MainView", {
            onInit: function () {
                const oModel = new JSONModel({
                    securityKey: "JBSWY3DPEHPK3PXP",
                    tokenDuration: 20,
                    tokenLength: 6,
                    percentValue: "100",
                    Token: "",
                });
                this.getView().setModel(oModel, "TokenInfo");

                this.oDataModel = this.getOwnerComponent().getModel("ABAP1909");
                this.triggerInterval();
            },
            getToken: function () {
                const { securityKey, tokenDuration, tokenLength } = this.getView().getModel("TokenInfo").oData;
                const Options = {
                    SecurityKey: securityKey,
                    tokenExpirey: parseInt(tokenDuration),
                    otplLen: parseInt(tokenLength),
                };
                return new Promise((resolve, reject) => {
                    this.oDataModel.create("/getTotpSet", Options, {
                        method: "POST",
                        success: function (Data) {
                            return resolve(Data);
                        }.bind(this),
                        error: function (error) {
                            return reject(error);
                        }.bind(this),
                    });
                }, this);
            },
            CalcualteRate: function (duration) {
                let currentPercentage = 100;
                let counter = -1;
                return function () {
                    currentPercentage = currentPercentage - 100 / duration;
                    counter++;
                    return { currentPercentage, counter };
                };
            },

            updateProgressIndicator: function (value) {
                this.getView().getModel("TokenInfo").setProperty("/percentValue", value);
                this.getView().getModel("TokenInfo").refresh();
            },
            triggerInterval: function () {
                const duration = this.getView().getModel("TokenInfo").getProperty("/tokenDuration");
                this.getToken().then((Data) => {
                    this.getView().getModel("TokenInfo").setProperty("/Token", Data.Token);
                    this.getView().getModel("TokenInfo").refresh();
                });

                let rateFn = new this.CalcualteRate(duration);

                if (this.setIntervalID) {
                    clearInterval(this.setIntervalID);
                }

                this.setIntervalID = setInterval(
                    function () {
                        let { currentPercentage, counter } = rateFn();

                        if (counter === duration) {
                            this.getToken()
                                .then((Data) => {
                                    this.getView().getModel("TokenInfo").setProperty("/Token", Data.Token);
                                    this.getView().getModel("TokenInfo").setProperty("/percentValue", "100");
                                    this.getView().getModel("TokenInfo").refresh();
                                    rateFn = new this.CalcualteRate(duration);
                                    currentPercentage = rateFn().currentPercentage;
                                    counter = rateFn().counter;
                                    this.updateProgressIndicator(currentPercentage);
                                })
                                .catch((Error) => {
                                    if (this.setIntervalID) {
                                        clearInterval(this.setIntervalID);
                                    }
                                });
                        } else {
                            this.updateProgressIndicator(currentPercentage);
                        }
                    }.bind(this),
                    1000,
                );
            },
        });
    },
);
