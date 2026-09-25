import 'package:club_server/src/config/app_config.dart';
import 'package:test/test.dart';

void main() {
  group('AppConfig', () {
    test('pinned Git dependencies require explicit opt-in', () {
      expect(AppConfig.fromMap({}).allowPinnedGitDependencies, isFalse);
      expect(
        AppConfig.fromMap({'allow_pinned_git_dependencies': true})
            .allowPinnedGitDependencies,
        isTrue,
      );
    });

    test('parses allowed hosted URLs from a comma-separated value', () {
      final config = AppConfig.fromMap({
        'allowed_hosted_urls':
            'https://registry.hippolabs.org/pub/internal-pub, '
            'https://packages.example.com',
      });

      expect(config.allowedHostedUrls, [
        'https://registry.hippolabs.org/pub/internal-pub',
        'https://packages.example.com',
      ]);
    });

    test('parses allowed hosted URLs from a list value', () {
      final config = AppConfig.fromMap({
        'allowed_hosted_urls': [
          'https://registry.hippolabs.org/pub/internal-pub',
          ' https://packages.example.com ',
          '',
        ],
      });

      expect(config.allowedHostedUrls, [
        'https://registry.hippolabs.org/pub/internal-pub',
        'https://packages.example.com',
      ]);
    });
  });
}
