<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent, EditorToolbarItem, RadioGroupItem } from '@nuxt/ui';
import { CalendarDate, DateFormatter, getLocalTimeZone } from '@internationalized/date'

definePageMeta({
    layout: 'dashboard'
})

const editorItems = [
  [
    {
      icon: 'i-lucide-heading',
      content: {
        align: 'start'
      },
      items: [
        {
          kind: 'heading',
          level: 1,
          icon: 'i-lucide-heading-1',
          label: 'Heading 1'
        },
        {
          kind: 'heading',
          level: 2,
          icon: 'i-lucide-heading-2',
          label: 'Heading 2'
        },
        {
          kind: 'heading',
          level: 3,
          icon: 'i-lucide-heading-3',
          label: 'Heading 3'
        },
        {
          kind: 'heading',
          level: 4,
          icon: 'i-lucide-heading-4',
          label: 'Heading 4'
        }
      ]
    }
  ],
  [
    {
      kind: 'mark',
      mark: 'bold',
      icon: 'i-lucide-bold'
    },
    {
      kind: 'mark',
      mark: 'italic',
      icon: 'i-lucide-italic'
    },
    {
      kind: 'mark',
      mark: 'underline',
      icon: 'i-lucide-underline'
    },
    {
      kind: 'mark',
      mark: 'strike',
      icon: 'i-lucide-strikethrough'
    },
    {
      kind: 'mark',
      mark: 'code',
      icon: 'i-lucide-code'
    }
  ]
] satisfies EditorToolbarItem[][]

const schema = z.object({
    title: z.string(),
    description: z.string(),
    content: z.string(),
    status: z.string(),
    date: z.string()
})

type Schema = z.output<typeof schema>

const df = new DateFormatter('en-US', {
  dateStyle: 'medium'
})
const today = new Date()

const toast = useToast()
const radioItems = ref<RadioGroupItem[]>([
    {
        label: 'Draft',
        id: 'draft'
    },
    {
        label: 'Published',
        id: 'published'
    }
])
const radioValue = ref('draft')
const modelValue = shallowRef(new CalendarDate(today.getFullYear(), today.getMonth() + 1, today.getDate()))

const state = reactive<Partial<Schema>>({
    title: undefined,
    description: undefined,
    content: undefined,
    status: radioValue.value,
    date: modelValue.value.toString()
})

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
    toast.add({ title: 'Success', description: 'Form has been submitted', color: 'success' })
    console.log(event.data)

    state.title = undefined
    state.description = undefined
    state.content = undefined
    state.status = radioValue.value
    state.date = new CalendarDate(today.getFullYear(), today.getMonth() + 1, today.getDate()).toString()
    modelValue.value = new CalendarDate(today.getFullYear(), today.getMonth() + 1, today.getDate())

    await navigateTo('/dashboard/blogs')
}
</script>

<template>
    <UContainer>
        <UButton
            label="Back to Blogs"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost"
            size="lg"
            :ui="{
                base: 'mt-10'
            }"
            to="/dashboard/blogs"
        />

        <UPageHeader
            title="Add Post"
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

                <UFormField label="Status" name="status" :ui="{ label: 'text-2xl font-semibold' }">
                    <URadioGroup
                        orientation="horizontal"
                        variant="list"
                        v-model="radioValue"
                        value-key="id"
                        :items="radioItems"
                    />
                </UFormField>

                <UFormField label="Date" name="date" :ui="{ label: 'text-2xl font-semibold' }">
                    <UPopover>
                        <UButton color="neutral" variant="subtle" icon="i-lucide-calendar">
                            {{ modelValue ? df.format(modelValue.toDate(getLocalTimeZone())) : 'Select a date' }}
                        </UButton>

                        <template #content>
                            <UCalendar
                                v-model="modelValue"
                                class="p-2"
                                disabled
                                size="xl"
                                @update:model-value="(val) => state.date = val ? val.toString() : undefined"
                            />
                        </template>
                    </UPopover>
                </UFormField>

                <UFormField label="Description" name="description" :ui="{ label: 'text-2xl font-semibold' }">
                    <UTextarea
                        class="w-full"
                        :rows="6"
                        v-model="state.description"
                    />
                </UFormField>

                <UFormField label="Content" name="content" :ui="{ label: 'text-2xl font-semibold' }">
                    <UEditor
                        v-slot="{ editor }"
                        v-model="state.content"
                        content-type="html"
                        :ui="{ base: 'p-8 sm:px-16' }"
                        class="w-full min-h-74 border border-accented"
                    >
                        <UEditorToolbar
                            :editor="editor"
                            :items="editorItems"
                            class="border-b border-muted py-2 px-8 sm:px-16 overflow-x-auto"
                        />
                    </UEditor>
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