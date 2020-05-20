// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
const importAll = (r) => r.keys().map(r)
const images = require.context('../images', false, /\.(png|jpe?g|svg)$/i)
importAll(images)
const imagePath = (name) => images(name, true)

import "intersection-observer"
import "alpinejs"
import "controllers"
import "stylesheets/application"

import nav_menu from 'nav_menu'
window.nav_menu = nav_menu;
