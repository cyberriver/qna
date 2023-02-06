// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//import Rails from "@rails/ujs"
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree

import Rails from '@rails/ujs';
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import "../stylesheets/application";
import { Tooltip, Toast, Popover } from 'bootstrap';
import Alert from 'bootstrap/js/dist/alert';
import "./answers";
import "./questions";

require("jquery")
require("channels")
require("@popperjs/core")
require("@nathanvda/cocoon")

import $ from "jquery";
window.jQuery = $
window.$ = $

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()

//require("answers")
