<script setup lang="ts">
const { data: about } = await useFetch<{
  id: string
  content: string
  image_url: string
}>('/api/about')

const { el } = useScrollAnimation()

const paragraphs = computed(() => {
  if (!about.value?.content) return []
  const text = about.value.content.replace(/<\/p>/g, '\n').replace(/<[^>]*>/g, '').trim()
  return text.split('\n').filter(p => p.trim())
})
</script>

<template>
  <section id="about" ref="el" class="reveal max-w-5xl mx-auto px-6 pt-24 pb-12">
    <div class="section-label">About</div>
    <h2 class="text-3xl sm:text-4xl font-bold tracking-tight mb-10">
      Building things that matter
    </h2>

    <div class="grid grid-cols-1 lg:grid-cols-5 gap-10 items-center">
      <!-- Image -->
      <div class="lg:col-span-2 flex justify-center" v-if="about">
        <NuxtImg
          :src="about.image_url"
          width="360"
          class="rounded-xl card-lift border border-[var(--ui-border)] w-full max-w-sm h-auto"
        />
      </div>

      <!-- Text -->
      <div class="lg:col-span-3 space-y-4" v-if="about">
        <p
          v-for="(para, index) in paragraphs.slice(0, 4)"
          :key="index"
          class="text-[var(--ui-text-dim)] leading-relaxed"
        >
          {{ para }}
        </p>
      </div>
    </div>
  </section>
</template>
