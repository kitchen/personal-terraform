'use strict';
exports.handler = (event, context, callback) => {
    const response = event.Records[0].cf.response;
    const headers = response.headers;

    headers['strict-transport-security'] = [{key: 'Strict-Transport-Security', value: 'max-age=31536042; includeSubDomains; preload'}];
    headers['x-frame-options'] = [{key: 'X-Frame-Options', value: 'DENY'}];
    csp_string = "frame-ancestors 'none'; default-src 'self' https://www.k1chn.com/ 'unsafe-inline' https://disqus.com https://*.disqus.com https://*.disquscdn.com; style-src https://fonts.googleapis.com https://cdn.cloudflare.com https://use.fontawesome.com"
    headers['content-security-policy'] = [{key: 'Content-Security-Policy', value: csp_string}];
    headers['x-xss-protection'] = [{key: 'X-XSS-Protection', value: '1; mode=block'}];
    headers['x-content-type-options'] = [{key: 'X-Content-Type-Options', value: 'nosniff'}]

    callback(null, response);
};
