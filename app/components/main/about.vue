<script setup lang="ts">
const { data: about } = await useFetch<{
  id: string
  content: string
  image_url: string
}>('/api/about')

const paragraphs = computed(() => {
  if (!about.value?.content) return []
  // Strip HTML tags and split by paragraphs
  const text = about.value.content.replace(/<\/p>/g, '\n').replace(/<[^>]*>/g, '').trim()
  return text.split('\n').filter(p => p.trim())
})
</script>

<template>
  <div id="about" class="flex flex-col mt-10">
    <UPageHeader
      title="About Me"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />

    <div v-if="about" class="flex flex-col lg:flex-row gap-6 mt-4">
      <div class="w-full lg:w-1/2">
        <p
          v-for="(para, index) in paragraphs"
          :key="index"
          class="text-muted mb-4 last:mb-0 text-justify"
        >
          {{ para }}
        </p>
      </div>

      <!-- Image (right on desktop, top on mobile) -->
      <div class="w-full lg:w-1/2 flex justify-center items-start">
        <NuxtImg
          :src="about.image_url"
          loading="lazy"
          width="400"
          class="w-full max-w-xs sm:max-w-sm lg:max-w-md rounded-xl"
          sizes="(max-width: 640px) 80vw, (max-width: 1024px) 50vw, 400px"
        />
      </div>
    </div>
  </div>
</template>
