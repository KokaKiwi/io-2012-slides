<h1><img src="images/io2012_logo.png"> HTML5 Slide Template</h1>

## Configuring the slides

Much of the deck is customized by changing the settings in [`slide_config.js`](slide_config.js).
Some of the customizations include the title, Analytics tracking ID, speaker
information (name, social urls, blog), web fonts to load, themes, and other
general behavior.

### Customizing the `#io12` hash

The bottom of the slides include `#io12` by default. If you'd like to change
this, please update the variable `$social-tags: '#io12';` in
[`/theme/scss/default.scss`](theme/scss/default.scss).

See the next section on "Editing CSS" before you go editing things.

## Editing CSS

[Lesscss](http://lesscss.org/) is a CSS preprocessor used to compile LessCSS
into CSS.

### Installing Lesscss and making changes

First, install less:

```sh
sudo npm install -g less
```

Next, make your changes, and re-compile CSS files:

```sh
lessc theme/less/default.less > theme/css/default.css
lessc theme/less/phone.less > theme/css/phone.css
```

## Running the slides

The slides can be run locally from `file://` making development easy :)

### Presenter mode

The slides contain a presenter mode feature (beta) to view + control the slides
from a popup window.

To enable presenter mode, add `presentme=true` to the URL: [http://localhost:8000/index.html?presentme=true](http://localhost:8000/index.html?presentme=true)

To disable presenter mode, hit [http://localhost:8000/index.html?presentme=false](http://localhost:8000/index.html?presentme=false)

Tip: You can enable Presenter mode by typing [T] key ;D

Presenter mode is sticky, so refreshing the page will persist your settings.

---

That's all she wrote!
Modified by KokaKiwi
