// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

document.addEventListener("turbo:load", () => {
    // Grab Elements
    const selectElement = (selector) => {
        const element = document.querySelector(selector);
        if(element) return element;
        throw new Error(`Something went wrong! Make sure that ${selector} exists/is typed correctly.`);
    };

//Nav styles on scroll
    const scrollHeader = () =>{
        const navbarElement = selectElement('#header');
        if(this.scrollY >= 15) {
            navbarElement.classList.add('activated');
        } else {
            navbarElement.classList.remove('activated');
        }
    }

    document.addEventListener('scroll', scrollHeader);

    const menuToggleIcon = selectElement('#menu-toggle-icon');

// Open menu and search pop-up
    const toggleMenu = () => {
        const mobileMenu = selectElement('#menu');
        mobileMenu.classList.toggle('activated');
        menuToggleIcon.classList.toggle('activated');
    };

    menuToggleIcon.addEventListener('click', toggleMenu);

// Open and close search form popup
    const formOpenBtn = selectElement('#search-icon');
    const formCloseBtn = selectElement('#form-close-btn');
    const searchFormContainer = selectElement('#search-form-container');

    formOpenBtn.addEventListener('click', () => searchFormContainer.classList.add('activated'));

    formCloseBtn.addEventListener('click', () => searchFormContainer.classList.remove('activated'));

// Close search form popup on ESC keypress
    window.addEventListener('keyup', event=> {
        if(event.key === 'Escape'){
            searchFormContainer.classList.remove('activated')
        }
    });

// Switch theme, add to local storage
    const bodyElement = document.body;
    const themeToggleBtn = selectElement('#theme-toggle-btn');
    const currentTheme = localStorage.getItem('currentTheme');

    if(currentTheme){
        bodyElement.classList.add('light-theme');
    }

    themeToggleBtn.addEventListener('click', () => {
        bodyElement.classList.toggle('light-theme');

        if(bodyElement.classList.contains('light-theme')){
            localStorage.setItem('currentTheme', 'themeActive');
        }else{
            localStorage.removeItem('currentTheme');
        }
    });
});