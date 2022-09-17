import { Application } from '@hotwired/stimulus'
import ReadMore from 'stimulus-read-more'
import Reveal from 'stimulus-reveal-controller'
import ScrollProgress from 'stimulus-scroll-progress'
import ScrollReveal from 'stimulus-scroll-reveal'

const application = Application.start()
application.register('read-more', ReadMore)
application.register('reveal', Reveal)
application.register('scroll-progress', ScrollProgress)
application.register('scroll-reveal', ScrollReveal)
