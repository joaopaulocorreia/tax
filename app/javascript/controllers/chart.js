import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

export default class extends Controller {
  static targets = [ "chart" ]
  static values = {
    one: Number,
    two: Number,
    three: Number,
    four: Number
  }

  connect(){
    const ctx = document.getElementById('myChart');

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: [
          'Até R$ 1.045,00',
          'De R$ 1.045,01 a R$ 2.089,60',
          'De R$ 2.089,61 até R$ 3.134,40',
          'De R$ 3.134,41 até R$ 6.101,06'
        ],
        datasets: [{
          label: '# of Proponents',
          data: [
            this.oneValue,
            this.twoValue,
            this.threeValue,
            this.fourValue
          ],
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }
}
