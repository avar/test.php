use inc::Module::Install;

name 'Test.php';
version '0.12';

author 'Ævar Arnfjörð Bjarmason <avar@cpan.org>';
abstract_from 'Test.php';
license 'unrestricted';

requires_external_bin 'php';

# Needs to be script, otherwise PAUSE will whine: "No package
# statements could be found in the distro (maybe a script or
# documentation distribution?)"
distribution_type 'script';

auto_install;
WriteAll;

package MY;

sub test
{
    return <<'END'
test:
	prove -r t

END
}
