export const helpers = {
  getArraysDiff: (a1: any[], a2: any[]) => {
    const a: any[] = []; const diff = [];

    for (const item1 of a1) {
      a[item1] = true;
    }

    for (const item2 of a2) {
      if (a[item2]) {
        delete a[item2];
      } else {
        a[item2] = true;
      }
    }

    for (const k in a) {
      diff.push(k);
    }

    return diff;
  },

  toFixedNumber(num: number, fractionDigits = -1) {
    const re = new RegExp(`^-?\\d+(?:\.\\d{0,${fractionDigits}})?`);
    const match = num.toString().match(re);
    const fixedNumber = Number(match);
    if (!fixedNumber) throw new Error(`Failed to trim decimal's fractional part from number: ${num}`);
    return fixedNumber;
  },
  /* eslint-disable no-useless-escape */
  
  async sleep(miliSeconds = 1000): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, miliSeconds));
  },

  stringify(json: object): string {
    return JSON.stringify(json, null, 2);
  },
};
