<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent, EditorToolbarItem, RadioGroupItem } from '@nuxt/ui';
import { CalendarDate, DateFormatter, getLocalTimeZone } from '@internationalized/date'
import TextAlign from '@tiptap/extension-text-align';

definePageMeta({
    layout: 'dashboard'
})

const route = useRoute()
const pageSlug = route.params.slug as string

const { data: post } = await useFetch<{
  id: string
  title: string
  description: string
  content: string
  slug: string
  status: 'published' | 'draft'
  date: string
}>(`/api/blogs/${pageSlug}`)

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
  ],
  [
    {
        icon: 'i-lucide-align-justify',
        tooltip: { text: 'Text Align' },
        content: {
            align: 'end'
        },
        items: [{
            kind: 'textAlign',
            align: 'left',
            icon: 'i-lucide-align-left',
            label: 'Align Left'
        }, {
            kind: 'textAlign',
            align: 'center',
            icon: 'i-lucide-align-center',
            label: 'Align Center'
        }, {
            kind: 'textAlign',
            align: 'right',
            icon: 'i-lucide-align-right',
            label: 'Align Right'
        }, {
            kind: 'textAlign',
            align: 'justify',
            icon: 'i-lucide-align-justify',
            label: 'Align Justify'
        }]
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
const postDate = post.value ? new Date(post.value.date) : new Date()

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
const radioValue = ref(post.value?.status || 'draft')
const modelValue = shallowRef(post.value ? new CalendarDate(postDate.getFullYear(), postDate.getMonth() + 1, postDate.getDate()) : new CalendarDate(new Date().getFullYear(), new Date().getMonth() + 1, new Date().getDate()))

const state = reactive<Partial<Schema>>({
    title: post.value?.title,
    description: post.value?.description,
    content: post.value?.content,
    status: radioValue.value,
    date: modelValue.value.toString()
})

const loading = ref(false)

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
  loading.value = true
  try {
    await $fetch(`/api/blogs/${pageSlug}`, {
      method: 'PUT',
      body: event.data
    })
    toast.add({ title: 'Success', description: 'Post updated successfully', color: 'success' })
    await navigateTo('/dashboard/blogs')
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  } finally {
    loading.value = false
  }
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
            title="Edit Post"
            description="Update your blog article"
            :ui="{
                root: 'border-b-0'
            }"
        />

        <UCard class="mb-20 animate-scale-in" v-if="post">
            <UForm
                :schema="schema"
                :state="state"
                @submit="onSubmit"
                class="flex flex-col gap-8"
            >
                <!-- Title + Meta row -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                  <UFormField label="Title" name="title" class="lg:col-span-2" :ui="{ label: 'text-2xl font-semibold' }">
                      <UInput
                          class="w-full"
                          size="xl"
                          v-model="state.title"
                      />
                  </UFormField>

                  <div class="space-y-6">
                    <UFormField label="Status" name="status" :ui="{ label: 'font-semibold' }">
                        <URadioGroup
                            orientation="horizontal"
                            variant="list"
                            v-model="radioValue"
                            value-key="id"
                            :items="radioItems"
                        />
                    </UFormField>

                    <UFormField label="Date" name="date" :ui="{ label: 'font-semibold' }">
                        <UPopover>
                            <UButton color="neutral" variant="subtle" icon="i-lucide-calendar" class="w-full justify-start">
                                {{ modelValue ? df.format(modelValue.toDate(getLocalTimeZone())) : 'Select a date' }}
                            </UButton>

                            <template #content>
                                <UCalendar
                                    v-model="modelValue"
                                    class="p-2"
                                    size="xl"
                                    @update:model-value="(val) => state.date = val ? val.toString() : undefined"
                                />
                            </template>
                        </UPopover>
                    </UFormField>
                  </div>
                </div>

                <!-- Description -->
                <UFormField label="Excerpt" name="description" :ui="{ label: 'text-2xl font-semibold' }">
                    <UTextarea
                        class="w-full"
                        :rows="4"
                        v-model="state.description"
                    />
                </UFormField>

                <!-- Content (Tiptap Editor) -->
                <UFormField label="Content" name="content" :ui="{ label: 'text-2xl font-semibold' }">
                    <div class="w-full border border-default rounded-lg overflow-hidden">
                      <UEditor
                          v-slot="{ editor }"
                          v-model="state.content"
                          content-type="html"
                          :extensions="[
                              TextAlign.configure({
                                  types: ['heading', 'paragraph']
                              })
                          ]"
                          :ui="{ base: 'p-8 sm:px-16 min-h-96' }"
                          class="w-full"
                      >
                          <UEditorToolbar
                              :editor="editor"
                              :items="editorItems"
                              class="border-b border-muted py-2 px-8 sm:px-16 overflow-x-auto bg-muted/20 sticky top-0 z-10"
                          />
                      </UEditor>
                    </div>
                </UFormField>

                <div class="flex justify-end pt-4 border-t border-default">
                  <UButton
                      type="submit"
                      color="neutral"
                      size="xl"
                      :loading="loading"
                      class="px-8"
                  >
                      Update Post
                  </UButton>
                </div>
            </UForm>
        </UCard>
    </UContainer>
</template>
