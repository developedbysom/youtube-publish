sap.ui.define(["sap/m/Title"], function (Title) {
  "use strict";

  return Title.extend("com.order.html5.control.TitleEx", {
    metadata: {
      events: {
        titlePress: {},
      },
    },

    renderer: {},
    onAfterRendering: function () {
      if (Title.prototype.onAfterRendering) {
        Title.prototype.onAfterRendering.apply(this, arguments);
      }
      var that = this;
      var title_id = "#" + this.getId() + "-inner";
      // this.$(".customer-name span")
      //   .click(() => {
      //     $this.click(function (oEvent) {
      //       that.fireTitlePress(oEvent);
      //     });
      //     $this.css("cursor", "pointer");
      //   })
      //   .bind(this);

      this.$()
        .find(title_id)
        .each(function () {
          var $this = $(this);
          $this.click(function (oEvent) {
            that.fireTitlePress(oEvent);
          });
          $this.css("cursor", "pointer");
        });
    },
  });
});
