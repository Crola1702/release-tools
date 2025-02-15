import _configs_.*
import javaposse.jobdsl.dsl.Job
// If failed to import locally be sure of using tools/ scripts
import org.yaml.snakeyaml.Yaml

// GZ COLLECTIONS
arch = 'amd64'

// Jenkins needs the relative path to work and locally the simulation is done
// using a symlink
file = readFileFromWorkspace("scripts/jenkins-scripts/dsl/gz-collections.yaml")
gz_collections_yaml = new Yaml().load(file)

gz_nightly = 'ionic'

String get_debbuilder_name(parsed_yaml_lib, parsed_yaml_packaging)
{
  major_version = parsed_yaml_lib.major_version

  ignore_major_version = parsed_yaml_packaging.linux?.ignore_major_version
  if (ignore_major_version && ignore_major_version.contains(parsed_yaml_lib.name))
    major_version = ""

  return parsed_yaml_lib.name + major_version + "-debbuilder"
}

gz_collection_jobs =
[
  'citadel' : [
        'ign_cmake-2-win',
        'ign_common-3-win',
        'ign_fuel-tools-4-win',
        'ign_gazebo-3-win',
        'ign_gui-3-win',
        'ign_math-6-win',
        'ign_msgs-5-win',
        'ign_physics-2-win',
        'ign_plugin-1-win',
        'ign_rendering-3-win',
        'ign_sensors-3-win',
        'ign_tools-1-win',
        'ign_transport-8-win',
        'ignition_citadel-ci-main-homebrew-amd64',
        'ignition_citadel-install-pkg-bionic-amd64',
        'ignition_citadel-install_bottle-homebrew-amd64',
        'ign_cmake-ci-ign-cmake2-bionic-amd64',
        'ign_cmake-ci-ign-cmake2-homebrew-amd64',
        'ignition_cmake2-install-pkg-focal-amd64',
        'ignition_cmake2-install_bottle-homebrew-amd64',
        'ign_common-ci-ign-common3-bionic-amd64',
        'ign_common-ci-ign-common3-homebrew-amd64',
        'ignition_common3-install-pkg-focal-amd64',
        'ignition_common3-install_bottle-homebrew-amd64',
        'ign_fuel-tools-ci-ign-fuel-tools4-bionic-amd64',
        'ign_fuel-tools-ci-ign-fuel-tools4-homebrew-amd64',
        'ignition_fuel-tools4-install-pkg-focal-amd64',
        'ignition_fuel-tools4-install_bottle-homebrew-amd64',
        'ign_gazebo-ci-ign-gazebo3-bionic-amd64',
        'ign_gazebo-ci-ign-gazebo3-homebrew-amd64',
        'ignition_gazebo3-install-pkg-focal-amd64',
        'ignition_gazebo3-install_bottle-homebrew-amd64',
        'ign_gui-ci-ign-gui3-bionic-amd64',
        'ign_gui-ci-ign-gui3-homebrew-amd64',
        'ignition_gui3-install-pkg-focal-amd64',
        'ignition_gui3-install_bottle-homebrew-amd64',
        'ign_launch-ci-ign-launch2-bionic-amd64',
        'ign_launch-ci-ign-launch2-homebrew-amd64',
        'ignition_launch2-install-pkg-focal-amd64',
        'ignition_launch2-install_bottle-homebrew-amd64',
        'ign_math-ci-ign-math6-bionic-amd64',
        'ign_math-ci-ign-math6-homebrew-amd64',
        'ignition_math6-install-pkg-focal-amd64',
        'ignition_math6-install_bottle-homebrew-amd64',
        'ign_msgs-ci-ign-msgs5-bionic-amd64',
        'ign_msgs-ci-ign-msgs5-homebrew-amd64',
        'ignition_msgs5-install-pkg-focal-amd64',
        'ignition_msgs5-install_bottle-homebrew-amd64',
        'ign_physics-ci-ign-physics2-bionic-amd64',
        'ign_physics-ci-ign-physics2-homebrew-amd64',
        'ignition_physics2-install-pkg-focal-amd64',
        'ignition_physics2-install_bottle-homebrew-amd64',
        'ign_plugin-ci-ign-plugin1-bionic-amd64',
        'ign_plugin-ci-ign-plugin1-homebrew-amd64',
        'ignition_plugin-install-pkg-focal-amd64',
        'ignition_plugin1-install_bottle-homebrew-amd64',
        'ign_rendering-ci-ign-rendering3-bionic-amd64',
        'ign_rendering-ci-ign-rendering3-homebrew-amd64',
        'ignition_rendering3-install-pkg-focal-amd64',
        'ignition_rendering3-install_bottle-homebrew-amd64',
        'ign_sensors-ci-ign-sensors3-bionic-amd64',
        'ign_sensors-ci-ign-sensors3-homebrew-amd64',
        'ignition_sensors3-install-pkg-focal-amd64',
        'ignition_sensors3-install_bottle-homebrew-amd64',
        'ign_tools-ci-ign-tools1-bionic-amd64',
        'ign_tools-ci-ign-tools1-homebrew-amd64',
        'ignition_tools-install-pkg-focal-amd64',
        'ignition_tools1-install_bottle-homebrew-amd64',
        'ign_transport-ci-ign-transport8-bionic-amd64',
        'ign_transport-ci-ign-transport8-homebrew-amd64',
        'ignition_transport8-install-pkg-focal-amd64',
        'ignition_transport8-install_bottle-homebrew-amd64',
        'sdformat-ci-sdf9-bionic-amd64',
        'sdformat-ci-sdf9-homebrew-amd64',
        'sdformat-install-sdformat9_pkg-focal-amd64',
        'sdformat-sdf9-win'
  ],
  'fortress' : [
        'gz_cmake-ign-cmake2-win',
        'gz_common-ign-common4-win',
        'gz_fuel_tools-ign-fuel-tools7-win',
        'gz_sim-ign-gazebo6-win',
        'gz_gui-ign-gui6-win',
        'gz_launch-ign-launch5-win',
        'gz_math-ign-math6-win',
        'gz_msgs-ign-msgs8-win',
        'gz_physics-ign-physics5-win',
        'gz_plugin-ign-plugin1-win',
        'gz_rendering-ign-rendering6-win',
        'gz_sensors-ign-sensors6-win',
        'gz_tools-ign-tools1-win',
        'gz_transport-ign-transport11-win',
        'gz_utils-ign-utils1-win',
        'gz_cmake-ci-ign-cmake2-focal-amd64',
        'gz_cmake-ci-ign-cmake2-homebrew-amd64',
        'gz_cmake2-install-pkg-focal-amd64',
        'ignition_cmake2-install_bottle-homebrew-amd64',
        'gz_common-ci-ign-common4-focal-amd64',
        'gz_common-ci-ign-common4-homebrew-amd64',
        'gz_common4-install-pkg-focal-amd64',
        'ignition_common4-install_bottle-homebrew-amd64',
        'ignition_fortress-ci-main-homebrew-amd64',
        'ignition_fortress-install-pkg-focal-amd64',
        'ignition_fortress-install_bottle-homebrew-amd64',
        'gz_fuel-tools-ci-ign-fuel-tools7-focal-amd64',
        'gz_fuel-tools-ci-ign-fuel-tools7-homebrew-amd64',
        'gz_fuel-tools7-install-pkg-focal-amd64',
        'ignition_fuel-tools7-install_bottle-homebrew-amd64',
        'gz_sim-ci-ign-gazebo6-focal-amd64',
        'gz_sim-ci-ign-gazebo6-homebrew-amd64',
        'ignition_gazebo6-install-pkg-focal-amd64',
        'ignition_gazebo6-install_bottle-homebrew-amd64',
        'gz_gui-ci-ign-gui6-focal-amd64',
        'gz_gui-ci-ign-gui6-homebrew-amd64',
        'gz_gui6-install-pkg-focal-amd64',
        'ignition_gui6-install_bottle-homebrew-amd64',
        'gz_launch-ci-ign-launch5-focal-amd64',
        'gz_launch-ci-ign-launch5-homebrew-amd64',
        'gz_launch5-install-pkg-focal-amd64',
        'ignition_launch5-install_bottle-homebrew-amd64',
        'gz_math-ci-ign-math6-focal-amd64',
        'gz_math-ci-ign-math6-homebrew-amd64',
        'gz_math6-install-pkg-focal-amd64',
        'ignition_math6-install_bottle-homebrew-amd64',
        'gz_msgs-ci-ign-msgs8-focal-amd64',
        'gz_msgs-ci-ign-msgs8-homebrew-amd64',
        'gz_msgs8-install-pkg-focal-amd64',
        'ignition_msgs8-install_bottle-homebrew-amd64',
        'gz_physics-ci-ign-physics5-focal-amd64',
        'gz_physics-ci-ign-physics5-homebrew-amd64',
        'gz_physics5-install-pkg-focal-amd64',
        'ignition_physics5-install_bottle-homebrew-amd64',
        'gz_plugin-ci-ign-plugin1-focal-amd64',
        'gz_plugin-ci-ign-plugin1-homebrew-amd64',
        'ignition_plugin-install-pkg-focal-amd64',
        'ignition_plugin1-install_bottle-homebrew-amd64',
        'gz_rendering-ci-ign-rendering6-focal-amd64',
        'gz_rendering-ci-ign-rendering6-homebrew-amd64',
        'gz_rendering6-install-pkg-focal-amd64',
        'ignition_rendering6-install_bottle-homebrew-amd64',
        'gz_sensors-ci-ign-sensors6-focal-amd64',
        'gz_sensors-ci-ign-sensors6-homebrew-amd64',
        'gz_sensors6-install-pkg-focal-amd64',
        'ignition_sensors6-install_bottle-homebrew-amd64',
        'gz_tools-ci-ign-tools1-focal-amd64',
        'gz_tools-ci-ign-tools1-homebrew-amd64',
        'ignition_tools-install-pkg-focal-amd64',
        'ignition_tools1-install_bottle-homebrew-amd64',
        'gz_transport-ci-ign-transport11-focal-amd64',
        'gz_transport-ci-ign-transport11-homebrew-amd64',
        'gz_transport11-install-pkg-focal-amd64',
        'ignition_transport11-install_bottle-homebrew-amd64',
        'gz_utils-ci-ign-utils1-focal-amd64',
        'gz_utils-ci-ign-utils1-homebrew-amd64',
        'ignition_utils-install-pkg-focal-amd64',
        'ignition_utils1-install_bottle-homebrew-amd64',
        'sdformat-ci-sdf12-focal-amd64',
        'sdformat-ci-sdf12-homebrew-amd64',
        'sdformat-install-sdformat12_pkg-focal-amd64',
        'sdformat-sdf12-win'
  ],
  'garden' : [
        'gz_cmake3-install-pkg-focal-amd64',
        'gz_common5-install-pkg-focal-amd64',
        'gz_fuel-tools8-install-pkg-focal-amd64',
        'gz_garden-install-pkg-focal-amd64',
        'gz_sim7-install-pkg-focal-amd64',
        'gz_gui7-install-pkg-focal-amd64',
        'gz_launch6-install-pkg-focal-amd64',
        'gz_math7-install-pkg-focal-amd64',
        'gz_msgs9-install-pkg-focal-amd64',
        'gz_physics6-install-pkg-focal-amd64',
        'gz_plugin2-install-pkg-focal-amd64',
        'gz_rendering7-install-pkg-focal-amd64',
        'gz_sensors7-install-pkg-focal-amd64',
        'gz_tools2-install-pkg-focal-amd64',
        'gz_transport12-install-pkg-focal-amd64',
        'gz_utils2-install-pkg-focal-amd64',
        'sdformat-install-sdformat13_pkg-focal-amd64',
        'gz_cmake-3-win',
        'gz_common-5-win',
        'gz_fuel-tools-8-win',
        'gz_sim-7-win',
        'gz_gui-7-win',
        'gz_launch-6-win',
        'gz_math-7-win',
        'gz_msgs-9-win',
        'gz_physics-6-win',
        'gz_plugin-2-win',
        'gz_rendering-7-win',
        'gz_sensors-7-win',
        'gz_tools-2-win',
        'gz_transport-12-win',
        'gz_utils-2-win',
        'sdformat-sdf13-win',
        'gz_cmake-ci-gz-cmake3-focal-amd64',
        'gz_cmake-ci-gz-cmake3-homebrew-amd64',
        'ignition_cmake3-install_bottle-homebrew-amd64',
        'gz_common-ci-gz-common5-focal-amd64',
        'gz_common-ci-gz-common5-homebrew-amd64',
        'ignition_common5-install_bottle-homebrew-amd64',
        'gz_fuel-tools-ci-gz-fuel-tools8-focal-amd64',
        'gz_fuel-tools-ci-gz-fuel-tools8-homebrew-amd64',
        'ignition_fuel-tools8-install_bottle-homebrew-amd64',
        'ignition_garden-ci-main-homebrew-amd64',
        'ignition_garden-install-pkg-focal-amd64',
        'ignition_garden-install_bottle-homebrew-amd64',
        'gz_sim-ci-gz-sim7-focal-amd64',
        'gz_sim-ci-gz-sim7-homebrew-amd64',
        'ignition_sim7-install_bottle-homebrew-amd64',
        'gz_gui-ci-gz-gui7-focal-amd64',
        'gz_gui-ci-gz-gui7-homebrew-amd64',
        'ignition_gui6-install_bottle-homebrew-amd64',
        'gz_launch-ci-gz-launch6-focal-amd64',
        'gz_launch-ci-gz-launch6-homebrew-amd64',
        'ignition_launch6-install_bottle-homebrew-amd64',
        'gz_math-ci-gz-math7-focal-amd64',
        'gz_math-ci-gz-math7-homebrew-amd64',
        'ignition_math7-install_bottle-homebrew-amd64',
        'gz_msgs-ci-gz-msgs9-focal-amd64',
        'gz_msgs-ci-gz-msgs9-homebrew-amd64',
        'ignition_msgs9-install_bottle-homebrew-amd64',
        'gz_physics-ci-gz-physics6-focal-amd64',
        'gz_physics-ci-gz-physics6-homebrew-amd64',
        'ignition_physics6-install_bottle-homebrew-amd64',
        'gz_plugin-ci-gz-plugin2-focal-amd64',
        'gz_plugin-ci-gz-plugin2-homebrew-amd64',
        'ignition_plugin2-install_bottle-homebrew-amd64',
        'gz_rendering-ci-gz-rendering7-focal-amd64',
        'gz_rendering-ci-gz-rendering7-homebrew-amd64',
        'ignition_rendering7-install_bottle-homebrew-amd64',
        'gz_sensors-ci-gz-sensors7-focal-amd64',
        'gz_sensors-ci-gz-sensors7-homebrew-amd64',
        'ignition_sensors7-install_bottle-homebrew-amd64',
        'gz_tools-ci-gz-tools2-focal-amd64',
        'gz_tools-ci-gz-tools2-homebrew-amd64',
        'ignition_tools2-install_bottle-homebrew-amd64',
        'gz_transport-ci-gz-transport12-focal-amd64',
        'gz_transport-ci-gz-transport12-homebrew-amd64',
        'ignition_transport12-install_bottle-homebrew-amd64',
        'gz_utils-ci-gz-utils2-focal-amd64',
        'gz_utils-ci-gz-utils2-homebrew-amd64',
        'ignition_utils2-install_bottle-homebrew-amd64',
        'sdformat-ci-sdf13-focal-amd64',
        'sdformat-ci-sdf13-homebrew-amd64'
  ],
  'harmonic' : [
        'gz_cmake-3-win',
        'gz_common-5-win',
        'gz_fuel-tools-9-win',
        'gz_sim-8-win',
        'gz_gui-8-win',
        'gz_launch-7-win',
        'gz_math-7-win',
        'gz_msgs-10-win',
        'gz_physics-7-win',
        'gz_plugin-2-win',
        'gz_rendering-8-win',
        'gz_sensors-8-win',
        'gz_tools-2-win',
        'gz_transport-13-win',
        'gz_utils-2-win',
        'gz_cmake-ci-gz-cmake3-jammy-amd64',
        'gz_common-ci-gz-common5-jammy-amd64',
        'gz_fuel_tools-ci-gz-fuel-tools9-jammy-amd64',
        'gz_gui-ci-gz-gui8-jammy-amd64',
        'gz_launch-ci-gz-launch7-jammy-amd64',
        'gz_math-ci-gz-math7-jammy-amd64',
        'gz_msgs-ci-gz-msgs10-jammy-amd64',
        'gz_physics-ci-gz-physics7-jammy-amd64',
        'gz_plugin-ci-gz-plugin2-jammy-amd64',
        'gz_rendering-ci-gz-rendering8-jammy-amd64',
        'gz_sensors-ci-gz-sensors8-jammy-amd64',
        'gz_sim-ci-gz-sim8-jammy-amd64',
        'gz_tools-ci-gz-tools2-jammy-amd64',
        'gz_transport-ci-gz-transport13-jammy-amd64',
        'gz_utils-ci-gz-utils2-jammy-amd64',
        'gz_cmake-ci-gz-cmake3-homebrew-amd64',
        'ignition_cmake3-install_bottle-homebrew-amd64',
        'gz_common-ci-gz-common5-homebrew-amd64',
        'ignition_common5-install_bottle-homebrew-amd64',
        'gz_fuel-tools-ci-gz-fuel-tools9-homebrew-amd64',
        'ignition_fuel-tools9-install_bottle-homebrew-amd64',
        'ignition_harmonic-ci-main-homebrew-amd64',
        'ignition_harmonic-install_bottle-homebrew-amd64',
        'gz_sim-ci-gz-sim8-homebrew-amd64',
        'ignition_sim8-install_bottle-homebrew-amd64',
        'gz_gui-ci-gz-gui8-homebrew-amd64',
        'ignition_gui8-install_bottle-homebrew-amd64',
        'gz_launch-gz-launch7-homebrew-amd64',
        'ignition_launch7-install_bottle-homebrew-amd64',
        'gz_math-ci-gz-math7-homebrew-amd64',
        'ignition_math7-install_bottle-homebrew-amd64',
        'gz_msgs-ci-gz-msgs10-homebrew-amd64',
        'ignition_msgs10-install_bottle-homebrew-amd64',
        'gz_physics-ci-gz-physics7-homebrew-amd64',
        'ignition_physics7-install_bottle-homebrew-amd64',
        'gz_plugin-ci-gz-plugin2-homebrew-amd64',
        'ignition_plugin2-install_bottle-homebrew-amd64',
        'gz_rendering-ci-gz-rendering8-homebrew-amd64',
        'ignition_rendering8-install_bottle-homebrew-amd64',
        'gz_sensors-ci-gz-sensors8-homebrew-amd64',
        'ignition_sensors8-install_bottle-homebrew-amd64',
        'gz_tools-ci-gz-tools2-homebrew-amd64',
        'ignition_tools2-install_bottle-homebrew-amd64',
        'gz_transport-ci-gz-transport13-homebrew-amd64',
        'ignition_transport13-install_bottle-homebrew-amd64',
        'gz_utils-ci-gz-utils2-homebrew-amd64',
        'ignition_utils2-install_bottle-homebrew-amd64',
        'sdformat-ci-sdf14-jammy-amd64',
        'sdformat-ci-sdf14-homebrew-amd64',
        'sdformat14-install_bottle-homebrew-amd64',
        'sdformat-sdf14-win'
  ],
  'ionic' : [
        'gz_cmake-main-win',
        'gz_common-main-win',
        'gz_fuel-tools-main-win',
        'gz_gazebo-main-win',
        'gz_gui-main-win',
        'gz_launch-main-win',
        'gz_math-main-win',
        'gz_msgs-main-win',
        'gz_physics-main-win',
        'gz_plugin-main-win',
        'gz_rendering-main-win',
        'gz_sensors-main-win',
        'gz_tools-2-win',
        'gz_transport-main-win',
        'gz_utils-main-win',
        'gz_cmake-ci-main-jammy-amd64',
        'gz_common-ci-main-jammy-amd64',
        'gz_fuel_tools-ci-main-jammy-amd64',
        'gz_gui-ci-main-jammy-amd64',
        'gz_launch-ci-main-jammy-amd64',
        'gz_math-ci-main-jammy-amd64',
        'gz_msgs-ci-main-jammy-amd64',
        'gz_physics-ci-main-jammy-amd64',
        'gz_plugin-ci-main-jammy-amd64',
        'gz_rendering-ci-main-jammy-amd64',
        'gz_sensors-ci-main-jammy-amd64',
        'gz_sim-ci-main-jammy-amd64',
        'gz_tools-ci-gz-tools2-jammy-amd64',
        'gz_transport-ci-main-jammy-amd64',
        'gz_utils-ci-main-jammy-amd64',
        'gz_cmake-ci-main-homebrew-amd64',
        'gz_common-ci-main-homebrew-amd64',
        'gz_fuel-tools-ci-main-homebrew-amd64',
        'gz_ionic-ci-main-homebrew-amd64',
        'gz_sim-ci-main-homebrew-amd64',
        'gz_gui-ci-main-homebrew-amd64',
        'gz_launch-ci-main-homebrew-amd64',
        'gz_math-ci-main-homebrew-amd64',
        'gz_msgs-ci-main-homebrew-amd64',
        'gz_physics-ci-main-homebrew-amd64',
        'gz_plugin-ci-main-homebrew-amd64',
        'gz_rendering-ci-main-homebrew-amd64',
        'gz_sensors-ci-main-homebrew-amd64',
        'gz_tools-ci-gz-tools2-homebrew-amd64',
        'gz_transport-ci-main-homebrew-amd64',
        'gz_utils-ci-main-homebrew-amd64',
        'sdformat-ci-main-jammy-amd64',
        'sdformat-ci-main-homebrew-amd64',
        'sdformat-main-win'
  ],
]

def DISABLE_TESTS           = false

void generate_install_job(prefix, gz_collection_name, distro, arch)
{
  def install_default_job = job("${prefix}_${gz_collection_name}-install-pkg-${distro}-${arch}")
  OSRFLinuxInstall.create(install_default_job)

  install_default_job.with
  {
    triggers {
      cron(Globals.CRON_EVERY_THREE_DAYS)
    }

    def dev_package = "${prefix}-${gz_collection_name}"
    def job_name = 'gz_launch-install-test-job.bash'

    label Globals.nontest_label("gpu-reliable")

    steps {
     shell("""\
           #!/bin/bash -xe

           export DISTRO=${distro}
           export ARCH=${arch}
           export INSTALL_JOB_PKG=${dev_package}
           export GZDEV_PROJECT_NAME="${dev_package}"
           if [[ ${gz_collection_name} == 'citadel' || ${gz_collection_name} == 'fortress' ]]; then
              export GZ_SIM_RUNTIME_TEST_USE_IGN=true
           fi
           /bin/bash -x ./scripts/jenkins-scripts/docker/${job_name}
           """.stripIndent())
    }
  }
}

// Testing compilation from source
gz_collections_yaml.collections.each { collection ->
  gz_collection_name = collection.name

  dashboard_name = "ign-${gz_collection_name}"
  if (gz_collection_name == "__upcoming__")
    dashboard_name = gz_collection_name

  // Gazebo dashboards
  // --------------------------------------------------------------
  dashboardView(dashboard_name)
  {
    jobs {
      gz_collection_jobs["${gz_collection_name}"].each { jobname ->
        name(jobname)
      }
      if (collection.packaging?.linux?.nightly) {
        collection.libs.each { lib ->
          name(get_debbuilder_name(lib, collection.packaging))
        }
      }
    }

    columns {
      status()
      weather()
      name()
      testResult(0)
      lastSuccess()
      lastFailure()
      lastDuration()
      buildButton()

    }

    bottomPortlets {
      jenkinsJobsList {
          displayName('Jenkins jobs list')
      }
    }

    configure { view ->
      view / columns << "hudson.plugins.warnings.WarningsColumn" (plugin: 'warnings@5.0.1')

      def topPortlets = view / NodeBuilder.newInstance().topPortlets {}

      topPortlets << 'hudson.plugins.view.dashboard.core.UnstableJobsPortlet' {
          id createPortletId()
          name 'Failing jobs'
          showOnlyFailedJobs 'true'
          recurse 'false'
      }
    }
  }

  if (! collection.packaging.exclude?.contains(gz_collection_name)) {
    // DEBBUILD: linux package builder
    // --------------------------------------------------------------
    def build_pkg_job = job("gz-${gz_collection_name}-debbuilder")
    OSRFLinuxBuildPkg.create(build_pkg_job)
    build_pkg_job.with
    {
      steps {
        shell("""\
              #!/bin/bash -xe

              /bin/bash -x ./scripts/jenkins-scripts/docker/multidistribution-ignition-debbuild.bash
              """.stripIndent())
      }
    }
  }


  collection.ci.configs.each { ci_config_name ->
    ci_config = gz_collections_yaml.ci_configs.find { it.name == ci_config_name }
    distro = ci_config.system.version
    arch = ci_config.system.arch

    // This should really include these two conditions to be effective:
    //   ci_config.exclude.all?.contains("gz-" + gz_collection_name)
    //   ci_config.exclude.all?.contains("ign-" + gz_collection_name)
    // However the collection package being processed here are superseed by the migration
    // to yaml efforts. Remove from here when -install- and -win- jobs are implemented
    // in gazebo_libs
    if (ci_config.exclude.all?.contains(gz_collection_name) ||
        ci_config.system.so == 'darwin' ||
        ci_config.system.so == 'windows')
      return

    // INSTALL JOBS:
    // --------------------------------------------------------------
    if ((gz_collection_name == "citadel") || (gz_collection_name == "fortress")) {
      generate_install_job('ignition', gz_collection_name, distro, arch)
    }
    generate_install_job('gz', gz_collection_name, distro, arch)

    // ROS BOOTSTRAP INSTALL JOBS:
    // --------------------------------------------------------------
    def install_ros_bootstrap_job =
    job("ignition_${gz_collection_name}-install-pkg_ros_bootstrap-any-manual")
    OSRFLinuxInstall.create(install_ros_bootstrap_job)
    install_ros_bootstrap_job.with
    {
      parameters {
        stringParam("LINUX_DISTRO", 'ubuntu', "Linux distribution to build packages for")
        stringParam("DISTRO", distro, "Linux release inside LINUX_DISTRO to build packages for")
        stringParam("ARCH", arch, "Architecture to build packages for")
        labelParam('JENKINS_NODE_TAG') {
          description('Jenkins node or group to run the build on')
          defaultValue('gpu-reliable')
        }
      }

      // Designed to be run manually. No triggers.
      label Globals.nontest_label("gpu-reliable")

      steps {
        systemGroovyCommand("""\
          build.setDescription(
          '<b>' + build.buildVariableResolver.resolve('LINUX_DISTRO') + '/' +
                  build.buildVariableResolver.resolve('DISTRO') + '::' +
                  build.buildVariableResolver.resolve('ARCH') + '</b>' +
          '<br />' +
          'RTOOLS_BRANCH: ' + build.buildVariableResolver.resolve('RTOOLS_BRANCH'));
          """.stripIndent())

        shell("""\
             #!/bin/bash -xe


             export INSTALL_JOB_PKG=ignition-${gz_collection_name}
             export USE_ROS_REPO=true
             export ROS_BOOTSTRAP=true
             # needed for arm64 machines and other arch tests
             export ENABLE_GZ_SIM_RUNTIME_TEST=false
             if [[ ${gz_collection_name} == 'citadel' || ${gz_collection_name} == 'fortress' ]]; then
                export GZ_SIM_RUNTIME_TEST_USE_IGN=true
             fi
             if [[ \${JENKINS_NODE_TAG} == 'gpu-reliable' ]]; then
               export ENABLE_GZ_SIM_RUNTIME_TEST=true
             fi
             /bin/bash -x ./scripts/jenkins-scripts/docker/gz_launch-install-test-job.bash
             """.stripIndent())
      }
    }

    // COLCON - Windows
    Globals.gazebodistro_branch = true
    def gz_win_ci_job = job("ign_${gz_collection_name}-ci-win")
    OSRFWinCompilation.create(gz_win_ci_job, false)
    gz_win_ci_job.with
    {
        steps {
          batchFile("""\
                set IGNITION_COLLECTION=${gz_collection_name}
                call "./scripts/jenkins-scripts/lib/ign_collection-base.bat"
                """.stripIndent())
        }
    }
    Globals.gazebodistro_branch = false

    // MAC Brew CI job
    // --------------------------------------------------------------
    def gz_brew_ci_job = job("ignition_${gz_collection_name}-ci-main-homebrew-amd64")
    OSRFBrewCompilation.create(gz_brew_ci_job, DISABLE_TESTS)
    OSRFGitHub.create(gz_brew_ci_job,
                      "gazebosim/gz-${gz_collection_name}",
                      "main",
                      "ign-${gz_collection_name}")
    gz_brew_ci_job.with
    {
        steps {
          shell("""\
                #!/bin/bash -xe

                /bin/bash -xe
                "./scripts/jenkins-scripts/lib/project-default-devel-homebrew-amd64.bash" "gz-${gz_collection_name}"
                """.stripIndent())
        }
    }

    // MAC Brew bottle install job
    // --------------------------------------------------------------
    def gz_brew_install_bottle_job = job("ignition_${gz_collection_name}-install_bottle-homebrew-amd64")
    OSRFBrewInstall.create(gz_brew_install_bottle_job)

    gz_brew_install_bottle_job.with
    {
      triggers {
        cron('@daily')
      }

      def bottle_name = "ignition-${gz_collection_name}"

      steps {
       shell("""\
             #!/bin/bash -xe

             /bin/bash -x ./scripts/jenkins-scripts/lib/project-install-homebrew.bash ${bottle_name}
             """.stripIndent())
      }

      publishers
      {
        configure { project ->
          project / publishers << 'hudson.plugins.logparser.LogParserPublisher' {
              unstableOnWarning true
              failBuildOnError false
              parsingRulesPath('/var/lib/jenkins/logparser_warn_on_mark_unstable')
          }
        }
      }
    }
  }
}

// NIGHTLY GENERATION
def get_nightly_branch(nightly_collection, lib)
{
  return nightly_collection.libs.find { it.name == lib }.repo.current_branch
}

nightly_collection = gz_collections_yaml.collections
  .find { it.name == gz_nightly }

def nightly_scheduler_job = job("ignition-${gz_nightly}-nightly-scheduler")
OSRFUNIXBase.create(nightly_scheduler_job)

nightly_scheduler_job.with
{
  label Globals.nontest_label("master")

  parameters
  {
     stringParam('NIGHTLY_PACKAGES',
                nightly_collection.libs.collect{
                  get_debbuilder_name(it,nightly_collection.packaging)
                    .replace("-debbuilder","")
                }.join(" "),
                'space separated list of packages to build')

     booleanParam('DRY_RUN',false,
                  'run a testing run with no effects')
  }

  triggers {
     cron(Globals.CRON_START_NIGHTLY)
  }

  cmake_branch = get_nightly_branch(nightly_collection, 'gz-cmake')
  common_branch = get_nightly_branch(nightly_collection, 'gz-common')
  fuel_tools_branch = get_nightly_branch(nightly_collection, 'gz-fuel-tools')
  sim_branch = get_nightly_branch(nightly_collection, 'gz-sim')
  gui_branch = get_nightly_branch(nightly_collection, 'gz-gui')
  launch_branch = get_nightly_branch(nightly_collection, 'gz-launch')
  math_branch = get_nightly_branch(nightly_collection, 'gz-math')
  msgs_branch =  get_nightly_branch(nightly_collection, 'gz-msgs')
  physics_branch = get_nightly_branch(nightly_collection, 'gz-physics')
  plugin_branch = get_nightly_branch(nightly_collection, 'gz-plugin')
  rendering_branch = get_nightly_branch(nightly_collection, 'gz-rendering')
  sensors_branch = get_nightly_branch(nightly_collection, 'gz-sensors')
  sdformat_branch = get_nightly_branch(nightly_collection, 'sdformat')
  tools_branch = get_nightly_branch(nightly_collection, 'gz-tools')
  transport_branch = get_nightly_branch(nightly_collection, 'gz-transport')
  utils_branch = get_nightly_branch(nightly_collection, 'gz-utils')

  steps {
    shell("""\
          #!/bin/bash -xe
          set +x # keep password secret
          PASS=\$(cat \$HOME/build_pass)

          dry_run_str=""
          if \$DRY_RUN; then
            dry_run_str="--dry-run"
          fi

          # redirect to not display the password
          for n in \${NIGHTLY_PACKAGES}; do

              if [[ "\${n}" != "\${n/cmake/}" ]]; then
                src_branch="${cmake_branch}"
              elif [[ "\${n}" != "\${n/common/}" ]]; then
                src_branch="${common_branch}"
              elif [[ "\${n}" != "\${n/fuel-tools/}" ]]; then
                src_branch="${fuel_tools_branch}"
              elif  [[ "\${n}" != "\${n/sim/}" ]]; then
                src_branch="${sim_branch}"
              elif  [[ "\${n}" != "\${n/gui/}" ]]; then
                src_branch="${gui_branch}"
              elif [[ "\${n}" != "\${n/launch/}" ]]; then
                src_branch="${launch_branch}"
              elif [[ "\${n}" != "\${n/math/}" ]]; then
                src_branch="${math_branch}"
              elif [[ "\${n}" != "\${n/msgs/}" ]]; then
                src_branch="${msgs_branch}"
              elif [[ "\${n}" != "\${n/physics/}" ]]; then
                src_branch="${physics_branch}"
              elif [[ "\${n}" != "\${n/plugin/}" ]]; then
                src_branch="${plugin_branch}"
              elif [[ "\${n}" != "\${n/rendering/}" ]]; then
                src_branch="${rendering_branch}"
              elif [[ "\${n}" != "\${n/sensors/}" ]]; then
                src_branch="${sensors_branch}"
              elif [[ "\${n}" != "\${n/sdformat/}" ]]; then
                src_branch="${sdformat_branch}"
              elif  [[ "\${n}" != "\${n/sim/}" ]]; then
                src_branch="${sim_branch}"
              elif [[ "\${n}" != "\${n/transport/}" ]]; then
                src_branch="${transport_branch}"
              elif [[ "\${n}" != "\${n/tools/}" ]]; then
                src_branch="${tools_branch}"
              elif [[ "\${n}" != "\${n/utils/}" ]]; then
                src_branch="${utils_branch}"
              else
                src_branch="main"
              fi

              echo "releasing \${n} (from branch \${src_branch})"
              python3 ./scripts/release.py \${dry_run_str} "\${n}" nightly "\${PASS}" --release-repo-branch main --nightly-src-branch \${src_branch} --upload-to-repo nightly > log || echo "MARK_AS_UNSTABLE"
              echo " - done"
          done

          """.stripIndent())
  }

  publishers
  {
     configure { project ->
       project / publishers << 'hudson.plugins.logparser.LogParserPublisher' {
          unstableOnWarning true
          failBuildOnError false
          parsingRulesPath('/var/lib/jenkins/logparser_warn_on_mark_unstable')
        }
     }
  }
}
