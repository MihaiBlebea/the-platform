class SocialFooter {
    facebookUrl      = null
    linkedinUrl      = null
    twitterUrl       = null
    elementId        = null
    triggerElementId = null

    constructor(data) {
        if (!data.hasOwnProperty('linkedin')) {
            throw Error('Linkedin share url is missing')
        }

        if (!data.hasOwnProperty('facebook')) {
            throw Error('Facebook share url is missing')
        }

        if (!data.hasOwnProperty('twitter')) {
            throw Error('Twitter share url is missing')
        }

        if (!data.hasOwnProperty('elementId')) {
            throw Error('ElementId is missing')
        }

        if (!data.hasOwnProperty('triggerElementId')) {
            throw Error('TriggerElementId is missing')
        }

        this.facebookUrl      = data['facebook']
        this.linkedinUrl      = data['linkedin']
        this.twitter          = data['twitter']
        this.elementId        = data['elementId']
        this.triggerElementId = data['triggerElementId']
    }

    scrolling() {
        if (this._isInView( document.getElementById( this.triggerElementId ))) {
            if (!this._isTriggered()) { this._attachFooter() }
        } else {
            if (this._isTriggered()) { this._deattachFooter() }
        }
    }

    _buildFooter() {
        // outside Wrapper
        let outsideWrapper = window.document.createElement('DIV')
        outsideWrapper.classList.add('footer-social', 'outside') // Add class to style the footer
        outsideWrapper.id = this.elementId

        let wrapper = window.document.createElement('DIV')
        wrapper.classList.add('inside') // Add class to style the footer

        // Label
        let label = window.document.createElement('SPAN')
        label.classList.add('label')
        label.innerHTML = 'Share on'

        // Linkedin
        let linkedinAnchor = window.document.createElement('A')
        linkedinAnchor.classList.add('no-underline')
        linkedinAnchor.href = linkedinUrl
        linkedinAnchor.target = '_blank'

        let linkedinIcon = window.document.createElement('I')
        linkedinIcon.className = 'fab fa-fw fa-linkedin-in'
        linkedinAnchor.appendChild(linkedinIcon)

        // Facebook
        let facebookAnchor = window.document.createElement('A')
        facebookAnchor.classList.add('no-underline')
        facebookAnchor.href = facebookUrl
        facebookAnchor.target = '_blank'

        let facebookIcon = window.document.createElement('I')
        facebookIcon.className = 'fab fa-fw fa-facebook-f'
        facebookAnchor.appendChild(facebookIcon)

        // Twitter
        let twitterAnchor = window.document.createElement('A')
        twitterAnchor.classList.add('no-underline')
        twitterAnchor.href = twitterUrl
        twitterAnchor.target = '_blank'

        let twitterIcon = window.document.createElement('I')
        twitterIcon.className = 'fab fa-fw fa-twitter'
        twitterAnchor.appendChild(twitterIcon)

        wrapper.appendChild(label)
        wrapper.appendChild(linkedinAnchor)
        wrapper.appendChild(facebookAnchor)
        wrapper.appendChild(twitterAnchor)

        outsideWrapper.appendChild(wrapper)

        return outsideWrapper
    }

    _attachFooter() {
        document.body.appendChild(
            this._buildFooter()
        )
    }

    _deattachFooter() {
        document.body.removeChild(
            document.getElementById(this.elementId)
        )
    }

    _isTriggered() {
        return document.getElementById(this.elementId) !== null
    }

    // Provide a html element
    _isInView(el) {
        const scroll = window.scrollY || window.pageYOffset
        const boundsTop = el.getBoundingClientRect().top + scroll
        
        const viewport = {
            top: scroll,
            bottom: scroll + window.innerHeight,
        }
        
        const bounds = {
            top: boundsTop,
            bottom: boundsTop + el.clientHeight,
        }
        
        return bounds.top <= viewport.top && bounds.bottom >= viewport.bottom
    }
}