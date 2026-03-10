<script setup lang="ts">
const props = defineProps({
  title: String,
  information: String,
  description: String
})
</script>

<template>
  <UCard class="w-full max-w-xl hover:ring-2 hover:ring-primary transition-all duration-200">
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
      >
        Read More
      </UButton>
    </div>
  </UCard>
</template>