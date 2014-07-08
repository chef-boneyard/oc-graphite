import getpass
from optparse import make_option

from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand, CommandError
from django.db import DEFAULT_DB_ALIAS


class Command(BaseCommand):
    option_list = BaseCommand.option_list + (
        make_option('--database', action='store', dest='database',
            default=DEFAULT_DB_ALIAS, help='Specifies the database to use. Default is "default".'),
    )
    help = "Change a user's password for django.contrib.auth from a script."

    requires_model_validation = False

    def handle(self, *args, **options):
        if len(args) > 2:
            raise CommandError("need exactly two arguments for username and password")

        username = args[0]
        password = args[1]

        UserModel = get_user_model()

        try:
            u = UserModel._default_manager.using(options.get('database')).get(**{
                    UserModel.USERNAME_FIELD: username
                })
        except UserModel.DoesNotExist:
            raise CommandError("user '%s' does not exist" % username)

        self.stdout.write("Changing password for user '%s'\n" % u)

        u.set_password(password)
        u.save()

        return "Password changed successfully for user '%s'" % u
