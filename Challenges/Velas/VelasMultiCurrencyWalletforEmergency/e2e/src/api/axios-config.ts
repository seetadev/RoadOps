export const axiosConfig = {
  // maxRedirects: 0,
  timeout: 35000,
  validateStatus: (status: number): boolean => status < 400,
  params: {},
};
