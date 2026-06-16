<template>
  <section id="hero" class="relative min-h-screen flex items-center overflow-hidden pt-20 pb-20">
    <!-- Glow orb -->
    <div class="hero-glow" />

    <div class="relative z-10 w-full max-w-4xl mx-auto px-6">
      <!-- Badge -->
      <div class="hero-badge animate-fade-in-up" style="animation-delay:0ms">
        <Icon name="i-lucide-sparkles" class="w-3.5 h-3.5" />
        Fullstack Developer
      </div>

      <!-- Name with gradient -->
      <h1 class="text-5xl sm:text-6xl lg:text-7xl font-extrabold tracking-tight leading-[1.2] mt-6 animate-fade-in-up text-transparent bg-clip-text bg-gradient-to-r from-[var(--ui-text)] to-[var(--ui-primary)]" style="animation-delay:100ms">
        Naufal Hafizh Nugraha
      </h1>

      <!-- Subtitle -->
      <p class="text-lg sm:text-xl text-[var(--ui-text-dim)] max-w-xl mt-5 leading-relaxed animate-fade-in-up" style="animation-delay:200ms">
        Javascript fullstack developer who turns complex problems into clean, performant interfaces. I specialise in Node.js, Nuxt, and Laravel.
      </p>

      <!-- Actions -->
      <div class="flex gap-4 flex-wrap mt-8 animate-fade-in-up" style="animation-delay:300ms">
        <UButton
          size="lg"
          color="primary"
          variant="solid"
          class="px-8 card-lift shadow-lg shadow-[var(--ui-primary)]/20"
          icon="i-lucide-arrow-down"
          to="#projects"
        >
          See my work
        </UButton>
        <UButton
          size="lg"
          color="neutral"
          variant="outline"
          class="px-8 card-lift"
          icon="i-lucide-mail"
          to="mailto:nugrahanaufalhafizh@gmail.com"
        >
          Get in touch
        </UButton>
      </div>
    </div>
  </section>
</template>
