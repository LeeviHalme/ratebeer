//= require jquery3
//= require popper
//= require bootstrap-sprockets

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import { beers } from "custom/utils";
import BreweryList from "custom/brewery_list";

// Init beers function for beers#list
beers();

// Init BreweryList class for breweries#list
new BreweryList();
