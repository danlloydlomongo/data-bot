<template>
    <div class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900">
        <header class="border-b border-gray-700/50">
            <div class="max-w-4xl mx-auto px-6 py-4">
                <Link href="/items" class="text-indigo-400 hover:text-indigo-300 font-medium">← Back to Items</Link>
            </div>
        </header>

        <main class="max-w-4xl mx-auto px-6 py-8">
            <h1 class="text-2xl font-bold text-white mb-6">Edit Item</h1>

            <form :action="`/items/${item.id}`" method="post" class="space-y-4">
                <input type="hidden" name="_token" :value="csrfToken">
                <input type="hidden" name="_method" value="put">
                <div>
                    <label for="title" class="block text-sm font-medium text-gray-300 mb-1">Title</label>
                    <input
                        id="title"
                        name="title"
                        type="text"
                        required
                        :value="item.title"
                        class="w-full px-4 py-2 bg-gray-800 border border-gray-600 rounded-lg text-white placeholder-gray-500 focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        placeholder="Item title"
                    />
                    <p v-if="errors.title" class="mt-1 text-sm text-red-400">{{ Array.isArray(errors.title) ? errors.title[0] : errors.title }}</p>
                </div>
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-300 mb-1">Description</label>
                    <textarea
                        id="description"
                        name="description"
                        rows="4"
                        class="w-full px-4 py-2 bg-gray-800 border border-gray-600 rounded-lg text-white placeholder-gray-500 focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        placeholder="Optional description"
                    >{{ item.description }}</textarea>
                    <p v-if="errors.description" class="mt-1 text-sm text-red-400">{{ Array.isArray(errors.description) ? errors.description[0] : errors.description }}</p>
                </div>
                <button type="submit" class="px-6 py-2 bg-indigo-500 hover:bg-indigo-400 text-white font-medium rounded-lg transition">
                    Update
                </button>
            </form>
        </main>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';
import { computed } from 'vue';

defineProps({
    item: Object,
    errors: { type: Object, default: () => ({}) },
});

const csrfToken = computed(() => document.querySelector('meta[name="csrf-token"]')?.getAttribute('content'));
</script>
