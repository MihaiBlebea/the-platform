(function () {
    let elem = document.getElementById('page-views-dashboard')
    console.log(elem)
    axios.get("/api/v1/page-views-dashboard").then((result) => {
        console.log(result.data)

        let data = result.data.map((pageView) => {
            return pageView.count
        })

        let labels = result.data.map((pageView) => {
            return pageView.date
        })

        showChart(data, labels, elem)
    }).catch((err) => {
        console.log(err.message)
    })

    const showChart = (data, labels, el) => {
        let ctx = el.getContext('2d')
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Page Views',
                    data: data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                },
                layout: {
                    padding: {
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0
                    }
                }
            }
        })
    }
    
    const formatDate = (d) => {
        let timestamp = Date.parse(d)
        let date = new Date(timestamp)
    
        return `${ date.getDate() }.${ formatMonth(date.getMonth()) }.${ date.getFullYear() }`
    }
    
    const formatMonth = (month) => {
        return ("0" + (month + 1)).slice(-2)
    }
})()