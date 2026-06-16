/**
 * useScrollAnimation - Intersection Observer based scroll-reveal composable
 *
 * Usage:
 *   const { el } = useScrollAnimation() → apply ref="el" to an element
 *   const { el } = useScrollAnimation({ threshold: 0.15 }) → custom threshold
 *
 * The element gets class "reveal" initially and "revealed" when scrolled into view.
 */
export function useScrollAnimation(options?: { threshold?: number; rootMargin?: string }) {
  const el = ref<HTMLElement | null>(null)

  onMounted(() => {
    if (!el.value) return

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          el.value?.classList.add('revealed')
          observer.unobserve(entry.target)
        }
      },
      {
        threshold: options?.threshold ?? 0.1,
        rootMargin: options?.rootMargin ?? '0px 0px -40px 0px',
      }
    )

    observer.observe(el.value)
    onUnmounted(() => observer.disconnect())
  })

  return { el }
}

/**
 * useStaggerAnimation - for staggered grid children
 * Usage:
 *   const { el } = useStaggerAnimation()
 *   <div :ref="el" class="stagger-children">...
 */
export function useStaggerAnimation(options?: { threshold?: number }) {
  const el = ref<HTMLElement | null>(null)

  onMounted(() => {
    if (!el.value) return

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          el.value?.classList.add('revealed')
          observer.unobserve(entry.target)
        }
      },
      { threshold: options?.threshold ?? 0.05 }
    )

    observer.observe(el.value)
    onUnmounted(() => observer.disconnect())
  })

  return { el }
}

/**
 * useScrollHeader - adds scrolled class to header when page is scrolled
 * Usage:
 *   const { scrolled } = useScrollHeader()
 *   :class="{ 'scrolled': scrolled }"
 */
export function useScrollHeader(offset = 40) {
  const scrolled = ref(false)

  onMounted(() => {
    const onScroll = () => {
      scrolled.value = window.scrollY > offset
    }
    onScroll()
    window.addEventListener('scroll', onScroll, { passive: true })
    onUnmounted(() => window.removeEventListener('scroll', onScroll))
  })

  return { scrolled }
}
