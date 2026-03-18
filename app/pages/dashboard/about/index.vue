<script setup lang="ts">
import type { ButtonProps } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

const paragraphs = [
  `Hi, I'm Naufal Hafizh Nugraha, a fullstack developer based in Indonesia.`,
  `I specialize in building and maintaining backend systems using technologies such as Node.js, Express.js, PostgreSQL, Redis, and Kafka. My work mainly focuses on designing APIs, debugging production issues, and improving system reliability in distributed environments.`,
  `My professional experience includes working on high-availability systems for digital document services and e-commerce platforms, where I handled critical incidents, optimized database queries, and stabilized backend services across development, staging, and production environments.`,
  `Currently, I also work as a freelance full-stack developer, building and improving manufacturing reporting systems using Nuxt.js, Laravel, and Microsoft SQL Server. My role involves translating operational requirements into technical implementations and delivering features that support real-world factory workflows.`,
  `My journey into software engineering started as a self-taught developer, where I spent over a year intensively learning web development fundamentals and backend architecture before entering the industry professionally.`,
  `Through this blog, I share what I learn about backend engineering, system design, debugging strategies, and modern web development.`,
  `Outside of coding, I'm interested in continuous learning, building personal projects, and exploring better ways to design reliable software systems.`
]

const links = ref<ButtonProps[]>([
  {
    label: 'Edit',
    icon: 'i-lucide-square-pen',
    to: '/dashboard/about/edit',
  }
])
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

        <UCard>
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
                        src="/profile_1.png"
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