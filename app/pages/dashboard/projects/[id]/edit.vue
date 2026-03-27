<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui';

definePageMeta({
    layout: 'dashboard'
})

const route = useRoute()

const itemId = route.params.id ? route.params.id : '0'

const schema = z.object({
    title: z.string(),
    stacks: z.array(z.string()),
    description: z.string(),
    link: z.string()
})

type Schema = z.output<typeof schema>

type Projects = {
    id: string,
    title: string
    stacks: string[]
    description: string
    link: string
}

const projects = ref<Projects[]> ([
  {
    id: '1',
    title: 'Simple World Map',
    stacks: [
      'Bun',
      'Javascript',
      'Svelte',
      'Sveltekit',
      'Supabase',
      'Leaflet'
    ],
    description: 'Simple world map built by svelte and supabase',
    link: 'https://github.com/valfidz/geo-map'
  },
  {
    id: '2',
    title: 'Pipopa Landing Page',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Landing page for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/pipopa-fe/tree/production'
  },
  {
    id: '3',
    title: 'Pipopa Dashboard',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Dashboard for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/admin-compro-cra-pipopa/tree/production'
  },
  {
    id: '4',
    title: 'Pipopa Backend',
    stacks: [
      'Javascript',
      'Node.js',
      'Express.js',
      'MySQL'
    ],
    description: 'Backend API for Pipopa company profile built by Express.js and MySQL',
    link: 'https://github.com/valfidz/pipopa-be/tree/production'
  },
])

const currentProject = projects.value.filter(project => project.id === itemId.toString())

const state = reactive<Partial<Schema>>({
    title: currentProject[0]?.title,
    stacks: currentProject[0]?.stacks,
    description: currentProject[0]?.description,
    link: currentProject[0]?.link
})

const toast = useToast()

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
    toast.add({ title: 'Success', description: 'Form has been submitted', color: 'success' })
    console.log(event.data)

    await navigateTo('/dashboard/projects')
}
</script>

<template>
    <UContainer>
        <UButton
            label="Back to Projects"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost"
            size="lg"
            :ui="{
                base: 'mt-10'
            }"
            to="/dashboard/projects"
        />

        <UPageHeader
            title="Edit Project"
            :ui="{
                root: 'border-b-0'
            }"
        />

        <UCard class="mb-20">
            <UForm
                :schema="schema"
                :state="state"
                @submit="onSubmit"
                class="flex flex-col gap-8"
            >
                <UFormField label="Title" name="title" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInput
                        class="w-full"
                        size="xl"
                        v-model="state.title"
                    />
                </UFormField>

                <UFormField label="Stacks" name="stacks" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInputTags
                        class="w-full"
                        size="xl"
                        v-model="state.stacks"
                    />
                </UFormField>

                <UFormField label="Description" name="description" :ui="{ label: 'text-2xl font-semibold' }">
                    <UTextarea
                        class="w-full"
                        :rows="12"
                        v-model="state.description"
                    />
                </UFormField>

                <UFormField label="Link" name="link" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInput
                        class="w-full"
                        size="xl"
                        v-model="state.link"
                    />
                </UFormField>

                <UButton
                    type="submit"
                    class="max-w-20 justify-center"
                    color="neutral"
                    size="xl"
                >
                    Submit
                </UButton>
            </UForm>
        </UCard>
    </UContainer>
</template>