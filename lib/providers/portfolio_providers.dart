import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portfolio_data.dart';

/// Provider for active navigation section key ('hero', 'projects', 'skills', 'experience', 'contact')
final activeSectionProvider = StateProvider<String>((ref) => 'hero');

/// Provider for filtering project categories
final projectCategoryFilterProvider = StateProvider<String>((ref) => 'All');

/// Filtered list of projects based on category selection
final filteredProjectsProvider = Provider<List<ProjectModel>>((ref) {
  final filter = ref.watch(projectCategoryFilterProvider);
  if (filter == 'All') {
    return PortfolioData.projects;
  }
  return PortfolioData.projects.where((p) => p.tags.contains(filter) || p.category == filter).toList();
});

/// Shared ScrollController for section jumping/scrolling
final scrollControllerProvider = Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

/// Global GlobalKeys for sections to support smooth scroll-to-index
final sectionKeysProvider = Provider<Map<String, GlobalKey>>((ref) {
  return {
    'hero': GlobalKey(debugLabel: 'hero'),
    'projects': GlobalKey(debugLabel: 'projects'),
    'skills': GlobalKey(debugLabel: 'skills'),
    'experience': GlobalKey(debugLabel: 'experience'),
    'education': GlobalKey(debugLabel: 'education'),
    'contact': GlobalKey(debugLabel: 'contact'),
  };
});
