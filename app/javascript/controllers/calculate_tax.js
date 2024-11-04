import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "salary" ]
  static values = {
    url: String
  }

  async calculate(){
    if(this.salaryTarget.value.length == 0 ){
      return document.getElementById('proponent_tax').setAttribute('value', '')
    }

    const finalUrl = `${this.urlValue}?salary=${this.salaryTarget.value}`

    const response = await fetch(finalUrl)
    const data = await response.json()

    document.getElementById('proponent_tax').setAttribute('value', data.calculated_tax)
    document.getElementById('proponent_tax_table_id').setAttribute('value', data.tax_table_id)
  }
}
