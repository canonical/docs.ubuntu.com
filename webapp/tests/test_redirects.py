from django.test import SimpleTestCase


class RedirectTestCase(SimpleTestCase):
    def _assertRedirect(self, requested, expected):
        self.assertRedirects(
            self.client.get(requested),
            expected,
            fetch_redirect_response=False,
        )

    def _assertDoesNotRedirect(self, requested):
        response = self.client.get(requested)
        self.assertTrue(response.status_code not in [301, 302])


class RedirectCoreTestCase(RedirectTestCase):
    def test_redirect_core_to_en(self):
        self._assertRedirect('/core', '/core/en/')
        self._assertRedirect('/core/', '/core/en/')
        self._assertRedirect('/core/en', '/core/en/')
        self._assertDoesNotRedirect('/core/en/')

    def test_does_not_redirect_maas_simple_path(self):
        self._assertDoesNotRedirect('/maas/2.1/en/test')

    def test_redirect_core_simple_path(self):
        expected = '/core/en/test'
        self._assertRedirect('/core/en/test/.html', expected)
        self._assertRedirect('/core/en/test/index.html', expected)


class RedirectPhoneTestCase(RedirectTestCase):
    def test_redirect_phone_to_en(self):
        self._assertRedirect('/phone', '/phone/en/')
        self._assertRedirect('/phone/', '/phone/en/')
        self._assertRedirect('/phone/en', '/phone/en/')
        self._assertDoesNotRedirect('/phone/en/')

    def test_redirect_phone_simple_path(self):
        expected = '/phone/en/test'
        self._assertRedirect('/phone/en/test/', expected)
        self._assertRedirect('/phone/en/test/.html', expected)
        self._assertRedirect('/phone/en/test/index.html', expected)


class RedirectMAASTestCase(RedirectTestCase):
    def test_does_not_redirect_maas_root_path(self):
        self._assertDoesNotRedirect('/maas/2.1/en/')

    def test_redirect_maas_to_en_with_version(self):
        expected = '/maas/2.1/en/'
        self._assertRedirect('/maas', expected)
        self._assertRedirect('/maas/', expected)
        self._assertRedirect('/maas/2.1', expected)
        self._assertRedirect('/maas/2.1/', expected)
        self._assertRedirect('/maas/2.1/en', expected)
        self._assertRedirect('/maas/en', expected)
        self._assertRedirect('/maas/en/', expected)

    def test_does_not_redirect_maas_simple_path(self):
        self._assertDoesNotRedirect('/maas/2.1/en/test')

    def test_redirect_maas_simple_path(self):
        expected = '/maas/2.1/en/test'
        self._assertRedirect('/maas/2.1/en/test/', expected)
        self._assertRedirect('/maas/2.1/en/test/.html', expected)
        self._assertRedirect('/maas/2.1/en/test/index.html', expected)

    def test_redirect_maas_simple_path_add_version(self):
        expected = '/maas/2.1/en/test'
        self._assertRedirect('/maas/en/test/', expected)
        self._assertRedirect('/maas/en/test/.html', expected)
        self._assertRedirect('/maas/en/test/index.html', expected)
