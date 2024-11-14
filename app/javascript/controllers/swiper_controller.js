import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper/bundle";

export default class extends Controller {
    connect() {
        console.log("Swiper initialized");
        this.swiper = new Swiper(".swiper-container", {
            slidesPerView: 1,
            spaceBetween: 30,
            keyboard: {
                enabled: true,
            }, 
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },       
            navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
            },
        });
    }
}

  console.log('テスト2');
