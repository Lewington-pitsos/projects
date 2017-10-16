const Browser = require('zombie');

var browser = new Browser();


browser.open();

console.log(browser.window);

browser.visit('http://zqdevres.qiniucdn.com/data/20110811173813/index.html');

//console.log(browser.body);
