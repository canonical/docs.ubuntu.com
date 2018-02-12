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
