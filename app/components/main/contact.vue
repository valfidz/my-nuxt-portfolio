<script setup lang="ts">
const link = 'https://bit.ly/CV-Softdev"'
</script>

<template>
  <div id="contact" class="flex flex-col mt-10">
    <UPageHeader
      title="Get In Touch"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-col gap-6 items-center">
      <p class="text-center text-muted max-w-xl">
        I'm always interested in discussing new opportunities, collaborating on projects, or simply talking about technology.
      </p>
      <MainContactCard
        :link="link"
      />
    </div>
  </div>
</template>