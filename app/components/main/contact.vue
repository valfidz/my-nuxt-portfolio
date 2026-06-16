<script setup lang="ts">
const link = 'https://bit.ly/CV-Softdev'
const { el } = useScrollAnimation()
</script>

<template>
  <section id="contact" ref="el" class="reveal max-w-5xl mx-auto px-6 pt-24 pb-20 text-center">
    <div class="section-label">Contact</div>
    <h2 class="text-3xl sm:text-4xl font-bold tracking-tight mb-4">
      Get in touch
    </h2>
    <p class="text-[var(--ui-text-dim)] max-w-lg mx-auto mb-10 leading-relaxed">
      I'm always interested in new opportunities, collaborations, or just talking about technology.
    </p>

    <div class="flex justify-center gap-4 flex-wrap">
      <UButton
        color="primary"
        variant="solid"
        size="lg"
        icon="i-lucide-mail"
        class="px-6 card-lift"
        to="mailto:nugrahanaufalhafizh@gmail.com"
      >
        Email Me
      </UButton>
      <UButton
        color="neutral"
        variant="outline"
        size="lg"
        icon="i-lucide-github"
        class="px-6 card-lift"
        to="https://github.com/valfidz"
        target="_blank"
      >
        GitHub
      </UButton>
      <UButton
        color="neutral"
        variant="outline"
        size="lg"
        icon="i-lucide-linkedin"
        class="px-6 card-lift"
        to="https://linkedin.com/in/nhafizh"
        target="_blank"
      >
        LinkedIn
      </UButton>
      <UButton
        color="neutral"
        variant="outline"
        size="lg"
        icon="i-lucide-download"
        class="px-6 card-lift"
        :to="link"
        target="_blank"
      >
        Resume
      </UButton>
    </div>
  </section>
</template>
