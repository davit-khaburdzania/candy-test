// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

document.addEventListener('DOMContentLoaded', function() {
  const form = document.querySelector('.message-form')

  var convDiv = document.querySelector(".conversation-container");
  convDiv.scrollTop = convDiv.scrollHeight;

  if (form) {
    form.addEventListener('turbo:submit-end', function() {
      const chatText = document.getElementById('chat-text');
      if (chatText) chatText.value = '';
    });

    document.documentElement.addEventListener('turbo:render', function() {
      var div = document.querySelector(".conversation-container");
      console.log("viiiiiii", div.scrollHeight);
      div.scrollTop = div.scrollHeight;
    })
  }
});