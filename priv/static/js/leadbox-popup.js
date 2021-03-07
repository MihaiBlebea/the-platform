(function(){
    // Keep track if popup has already been triggered
    let triggered = false
    window.addEventListener('scroll', function() {
        // Current position of the scroll
        let currentH = document.documentElement.scrollTop || document.body.scrollTop

        // Total screen height
        let totalH = (document.height !== undefined) ? document.height : document.body.offsetHeight

        // Middle of the page
        let screenMiddleH = Math.floor(totalH / 2)

        // Calculate middle of the current position
        let isMiddle = (currentH > screenMiddleH - 100 && currentH < screenMiddleH + 100)
        
        if (isMiddle && triggered === false) {
            // Set the already triggered flag to true
            triggered = true
            
            $('#modal-lead').modal('show');
        }
        // document.getElementById('showScroll').innerHTML = window.pageYOffset + 'px';
    })
})()