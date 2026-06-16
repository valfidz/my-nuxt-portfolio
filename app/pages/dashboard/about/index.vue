<script setup lang="ts">
definePageMeta({
    layout: 'dashboard'
})

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
    <UContainer>
        <UPageHeader
            title="About Me"
            :ui="{
                root: 'border-b-0'
            }"
        >
            <template #links>
                <UButton
                    label="Edit"
                    color="neutral"
                    size="lg"
                    icon="i-lucide-square-pen"
                    to="/dashboard/about/edit"
                />
            </template>
        </UPageHeader>

        <UCard v-if="about">
            <div class="flex flex-row gap-2">
                <div class="w-full lg:w-1/2">
                    <p
                        v-for="(para, index) in paragraphs"
                        :key="index"
                        class="text-muted mb-4 last:mb-0 text-justify"
                        >
                        {{ para }}
                    </p>
                </div>
                <div class="w-full lg:w-1/2">
                    <NuxtImg
                        :src="about.image_url"
                        loading="lazy"
                        width="400"
                        class="w-full max-w-xs sm:max-w-sm lg:max-w-md rounded-xl"
                        sizes="(max-width: 640px) 80vw, (max-width: 1024px) 50vw, 400px"
                    />
                </div>
            </div>
        </UCard>
    </UContainer>
</template>
