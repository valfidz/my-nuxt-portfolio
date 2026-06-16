<script setup lang="ts">
import * as z from 'zod'
import type { Form, FormSubmitEvent, EditorToolbarItem  } from '@nuxt/ui';
import type { Editor } from '@tiptap/vue-3'

definePageMeta({
    layout: 'dashboard'
})

const items = [
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
    },
    { kind: 'paragraph', icon: 'i-lucide-type', label: 'Paragraph' },
  ],
  [
    { kind: 'mark', mark: 'bold', icon: 'i-lucide-bold' },
    { kind: 'mark', mark: 'italic', icon: 'i-lucide-italic' },
    { kind: 'mark', mark: 'underline', icon: 'i-lucide-underline' },
    { kind: 'mark', mark: 'strike', icon: 'i-lucide-strikethrough' },
    { kind: 'mark', mark: 'code', icon: 'i-lucide-code' },
  ],
  [
    { kind: 'codeBlock', icon: 'i-lucide-file-code-2', label: 'Code Block' },
    { kind: 'blockquote', icon: 'i-lucide-text-quote', label: 'Quote' },
  ],
  [
    { kind: 'bulletList', icon: 'i-lucide-list', label: 'Bullet List' },
    { kind: 'orderedList', icon: 'i-lucide-list-ordered', label: 'Numbered List' },
  ],
  [
    { kind: 'horizontalRule', icon: 'i-lucide-minus', label: 'Divider' },
  ]
] satisfies EditorToolbarItem[][]

const { data: aboutData } = await useFetch<{
  id: string
  content: string
  image_url: string
}>('/api/about')

const schema = z.object({
    about: z.string(),
    image: z
            .instanceof(File, { message: 'Please select an image' })
            .refine((file) => file.size <= 5 * 1024 * 1024, 'File size must be less than 5MB')
            .refine(
                (file) => ['image/jpeg', 'image/png', 'image/webp'].includes(file.type),
                'Only .jpg, .png, and .webp files are accepted'
            ).optional()
})

const data = {
    about: aboutData.value?.content || '',
    imgPath: aboutData.value?.image_url || '/profile_1.png'
}

const imagePreview = ref<string | null>(data.imgPath)

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
    about: data.about,
    image: undefined
})

const toast = useToast()
const loading = ref(false)

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
  loading.value = true
  try {
    await $fetch('/api/about', {
      method: 'PUT',
      body: {
        content: event.data.about,
        image_url: data.imgPath
      }
    })
    toast.add({ title: 'Success', description: 'About page updated successfully', color: 'success' })
    await navigateTo('/dashboard/about')
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  } finally {
    loading.value = false
  }
}

const createObjUrl = (file: File): string => {
    return URL.createObjectURL(file)
}

watch(() => state.image, (file) => {
    if (file) {
        imagePreview.value = createObjUrl(file)
    }
})
</script>

<template>
    <UContainer>
        <UButton
            label="Back to About"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost"
            size="lg"
            :ui="{
                base: 'mt-10'
            }"
            to="/dashboard/about"
        />

        <UPageHeader
            title="Edit About"
            description="Update your personal information and profile image"
            :ui="{
                root: 'border-b-0'
            }"
        />

        <UCard class="mb-20 animate-scale-in">
            <UForm
                :schema="schema"
                :state="state"
                @submit="onSubmit"
                class="flex flex-col gap-8"
            >
                <!-- About Content -->
                <UFormField label="About" name="about" :ui="{ label: 'text-2xl font-semibold' }">
                    <div class="w-full border border-default rounded-lg overflow-hidden">
                      <UEditor
                          v-slot="{ editor }"
                          v-model="state.about"
                          content-type="html"
                          placeholder="Write about yourself... Type / for commands, or use the toolbar above"
                          :ui="{ base: 'p-8 sm:px-16 min-h-96' }"
                          class="w-full"
                      >
                          <UEditorToolbar
                              :editor="editor"
                              :items="items"
                              class="border-b border-muted py-2 px-8 sm:px-16 overflow-x-auto bg-muted/20 sticky top-0 z-10"
                          />
                          <UEditorDragHandle :editor="editor" />
                      </UEditor>
                    </div>
                </UFormField>

                <!-- Image -->
                <UFormField label="Image" name="image" :ui="{ label: 'text-2xl font-semibold' }">
                    <UFileUpload
                        size="xl"
                        variant="area"
                        label="Drop your image here"
                        description="PNG, JPG, or WEBP (max. 5MB)"
                        v-slot="{ open, removeFile }"
                        v-model="state.image"
                        accept="image/jpeg,image/png,image/webp"
                        class="w-full"
                    >
                        <img
                            v-if="imagePreview"
                            :src="imagePreview"
                            class="w-48 h-48 object-cover rounded-lg border border-default mx-auto"
                            alt="Profile Image"
                        />

                        <div class="flex gap-2 justify-center mt-4">
                            <UButton
                                :label="state.image ? 'Change image' : 'Upload new image'"
                                color="neutral"
                                variant="outline"
                                icon="i-lucide-upload"
                                @click="open()"
                            />

                            <UButton
                                v-if="state.image"
                                label="Remove"
                                color="error"
                                variant="outline"
                                @click="() => { removeFile(); imagePreview = data.imgPath }"
                            />
                        </div>

                        <p v-if="state.image" class="text-xs text-muted text-center mt-2">
                            {{ state.image.name }}
                        </p>
                    </UFileUpload>
                </UFormField>

                <div class="flex justify-end pt-4 border-t border-default">
                  <UButton
                      type="submit"
                      color="neutral"
                      size="xl"
                      :loading="loading"
                      class="px-8"
                  >
                      Save Changes
                  </UButton>
                </div>
            </UForm>
        </UCard>
    </UContainer>
</template>
