// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//import Rails from "@rails/ujs"
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require action_cable
//= require activestorage
//= require turbolinks
//= require_tree

import Rails from '@rails/ujs';
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import * as ActionCable from "@rails/actioncable";

import "channels";
import "bootstrap";
import "../stylesheets/application";
import { Tooltip, Toast, Popover } from 'bootstrap';
import Alert from 'bootstrap/js/dist/alert';
import 'bootstrap-icons/font/bootstrap-icons.css';
import "./answers";
import "./questions";
import "./comments";

var App = App || {};
App = ActionCable.createConsumer();

require("jquery");
require("channels");
require("@popperjs/core");
require("@nathanvda/cocoon");

import $ from "jquery";
window.jQuery = $;
window.$ = $;

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();


