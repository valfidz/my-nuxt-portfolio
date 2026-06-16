<script setup lang="ts">
const props = defineProps({
  title: String,
  information: String,
  description: String,
  slug: String
})
</script>

<template>
  <NuxtLink :to="`/blog/${props.slug}`" class="block w-full max-w-xl">
    <UCard class="hover:ring-2 hover:ring-primary transition-all duration-200">
      <div class="flex flex-col gap-4">
        <div>
          <h3 class="text-xl font-semibold">{{ props.title }}</h3>
          <p class="text-muted text-sm">{{ props.information }}</p>
        </div>
        <p class="text-muted text-sm sm:text-base line-clamp-3">
          {{ props.description }}
        </p>
        <UButton
          color="neutral"
          variant="outline"
          trailing-icon="i-lucide-external-link"
          class="self-start"
          :to="`/blog/${props.slug}`"
        >
          Read More
        </UButton>
      </div>
    </UCard>
  </NuxtLink>
</template>
