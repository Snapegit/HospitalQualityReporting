const postcssPxToViewport = require("postcss-px-to-viewport");
module.exports = ({ file }) => {

  const isEnablePostCssToViewPort = file.dirname.includes('mobile')


  return {
    plugins: [
      ...(isEnablePostCssToViewPort ? [postcssPxToViewport({
        unitToConvert: "px",
        viewportWidth: 750,
        unitPrecision: 5,
        propList: ["*"],
        viewportUnit: "vw",
        fontViewportUnit: "vw",
        selectorBlackList: [],
        minPixelValue: 1,
        mediaQuery: false,
        replace: true,
        landscape: false,
        landscapeUnit: "vw",
        landscapeWidth: 568,
      })] : [])
    ],
  };
};