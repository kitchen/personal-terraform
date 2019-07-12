This is some terraform code I've been using to manage some of my online stuff.

Right now it's all AWS. And not all of my AWS, just some of it. But I want to have it encapsulate more things.

Like I'll probably push this all down into a subdirectory and have a "root account" terraform directory that manages my non-root users and privileges and this one which is using a lesser privileged account to manage things it needs to be able to manage.

I'll probably also move my statefile into S3 at some point, but since I'm the only person using it, it's fine for it to be in git for the moment. The backup doesn't really need to be there, but why not, right?

See [LICENSE](LICENSE) for exact details, but honestly I doubt any of this is really "copyrightable" but because Reasons™ I'll at least give it a license. Enjoy.