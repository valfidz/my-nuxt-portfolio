<template>
  <UPageHeader
    title="Naufal Hafizh Nugraha"
    description="Javascript Fullstack Developer"
    :ui="{
        root: 'border-b-0',
        title: 'mx-auto',
        description: 'text-center'
    }"
    class="mt-10"
  />
  <div class="flex flex-row gap-8 justify-center">
    <UButton
        icon="i-lucide-github"
        size="lg"
        color="neutral"
        variant="solid"
        class="px-6"
        to="https://github.com/valfidz"
    >View Work
    </UButton>
    <UButton
        icon="i-lucide-mail"
        size="lg"
        color="neutral"
        variant="outline"
        class="px-6"
        to="mailto:nugrahanaufalhafizh@gmail.com"
        >Get in Touch
    </UButton>
  </div>
</template>
