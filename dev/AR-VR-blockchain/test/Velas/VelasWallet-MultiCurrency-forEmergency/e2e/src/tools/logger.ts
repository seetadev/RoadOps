import tracer from 'tracer';
import { config } from '../config';

const defaultLogFormat = '{{timestamp}} <{{title}}> ({{file}}:{{line}}) {{message}}';

export type LogLevel = 'error' | 'fatal' | 'warn' | 'info' | 'trace' | 'debug' | 'all';

export const log = tracer.colorConsole({
  dateformat: 'HH:MM:ss.L',
  format: [
    defaultLogFormat,
    {
      fatal: `${defaultLogFormat}\n{{stack}}`,
    },
  ],
  level: config.logLevel || 'info',
});
