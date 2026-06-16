<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui';

definePageMeta({
    layout: 'dashboard'
})

const route = useRoute()
const itemId = route.params.id as string

const { data: project } = await useFetch<{
  id: string, title: string, stacks: string[], description: string, link: string
}>(`/api/projects/${itemId}`)

const schema = z.object({
    title: z.string(),
    stacks: z.array(z.string()),
    description: z.string(),
    link: z.string()
})

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
    title: project.value?.title,
    stacks: project.value?.stacks,
    description: project.value?.description,
    link: project.value?.link
})

const toast = useToast()

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
  try {
    await $fetch(`/api/projects/${itemId}`, {
      method: 'PUT',
      body: event.data
    })
    toast.add({ title: 'Success', description: 'Project updated successfully', color: 'success' })
    await navigateTo('/dashboard/projects')
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  }
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

        <UCard class="mb-20" v-if="project">
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
