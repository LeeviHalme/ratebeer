export default class BreweryList {
  constructor() {
    this.breweries = [];
    this.brewery_table = document.querySelector("#breweries_table");

    this.activeLabel = '<span class="badge bg-success">Active</span>';
    this.retiredLabel = '<span class="badge bg-secondary">Retired</span>';

    if (this.brewery_table) {
      this.init();
      this.registerEventListeners();
    }
  }

  registerEventListeners() {
    const sortByNameButton = document.querySelector("#sort_by_name");
    const sortByYearButton = document.querySelector("#sort_by_year");
    const sortByBeerCountButton = document.querySelector("#sort_by_beer_count");

    if (sortByNameButton) {
      sortByNameButton.addEventListener("click", () => this.sortByName());
    }

    if (sortByYearButton) {
      sortByYearButton.addEventListener("click", () => this.sortByYear());
    }

    if (sortByBeerCountButton) {
      sortByBeerCountButton.addEventListener("click", () => this.sortByBeerCount());
    }
  }

  sortByName() {
    this.breweries.sort((a, b) => a.name.localeCompare(b.name));
    this.injectBreweries();
  }

  sortByYear() {
    this.breweries.sort((a, b) => a.year - b.year);
    this.injectBreweries();
  }

  sortByBeerCount() {
    this.breweries.sort((a, b) => b.beers.length - a.beers.length);
    this.injectBreweries();
  }

  async updateBreweries() {
    const response = await fetch("/breweries.json");
    const breweries = await response.json();

    this.breweries = breweries;
  }

  injectBreweries() {
    const tableBody = this.brewery_table.querySelector("tbody");

    if (!tableBody) return;

    tableBody.innerHTML = "";

    this.breweries.forEach(brewery => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${brewery.name}</td>
        <td>${brewery.year}</td>
        <td>${brewery.beers.length}</td>
        <td>${brewery.active ? this.activeLabel : this.retiredLabel}</td>
      `;
      tableBody.appendChild(row);
    });
  }

  async init() {
    await this.updateBreweries();

    this.injectBreweries();
  }
}
