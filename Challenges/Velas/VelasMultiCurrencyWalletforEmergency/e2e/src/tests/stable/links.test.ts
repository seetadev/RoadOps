import { assert, test } from '../../common-test-exports';

test.describe('Links', () => {
  test.beforeEach(async ({ auth }) => {
    await auth.goto();
  });

  test('Download links are correct', async ({ page, auth }) => {
    const appleLink = await auth.downloadButtons.iOS.getAttribute('href');
    const androidLink = await auth.downloadButtons.android.getAttribute('href');
    const apkLink = await auth.downloadButtons.apk.getAttribute('href');

    assert.isTrue(appleLink?.includes('https://apps.apple.com/'));
    assert.isTrue(androidLink?.includes('https://play.google.com/'));
    assert.isTrue(apkLink?.includes('https://github.com/velas/mobile-wallet/releases/latest/download/'));

    await auth.downloadButtons.desktop.click();
    await auth.installWallets.platformsList.waitFor();
    await page.waitForSelector('.platforms');

    const donwloadLinks = await page.$$('a');
    for (let i = 0; i < donwloadLinks.length; i++) {
      const linkElement = donwloadLinks[i];
      const downloadLink = await linkElement.getAttribute('href');
      if (!downloadLink?.includes('snapcraft')){
        const linkText = await linkElement.textContent();
        assert.isTrue(downloadLink?.includes('https://github.com/velas/JsWalletDesktop'), `${linkText} doesn't lead to correct destination`);        
      }
    }
  });
});
