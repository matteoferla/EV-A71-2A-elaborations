# job40
: << USAGE
export JOB_SCRIPT=/data/xchem-fragalysis/shared/singularity.sh;
export APPTAINER_CONTAINER=/data/xchem-fragalysis/shared/singularity/rockyplus.sif;
export JOB_INNER_SCRIPT=/data/xchem-fragalysis/mferla/ASAP/A71/job.sh;
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-39.novalocal")'
USAGE

export HOST=${HOST:-$(hostname)}
export USER=${USER:-$(users)}
export HOME=${HOME:-$_CONDOR_SCRATCH_DIR}
source /etc/os-release;
echo "Running script ${0} as $USER in $HOST which runs $PRETTY_NAME"
# ---------------------------------------------------------------

source /data/xchem-fragalysis/mferla/.bashrc;
conda activate compchem;

cd $HOME2/ASAP/A71;
pwd;
export TEMPLATE='template.pdb'
export HITS='fragmented_P1.sdf'


N_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)

nice -19 fragmenstein pipeline \
--template $TEMPLATE \
--input $HITS \
--n_cores $(($N_CORES - 1)) --suffix _pairs \
--max_tasks 5000 \
--workfolder /data/outerhome/tmp \
--sw_databases REAL-Database-22Q1.smi.anon \
--combination_size 2 \
-v \
--timeout 600;

echo 'COMPLETE'

nice -19 fragmenstein pipeline \
--template $TEMPLATE \
--input $HITS \
--n_cores $(($N_CORES - 1)) --suffix _trio \
--max_tasks 5000 \
--workfolder /data/outerhome/tmp \
--sw_databases REAL-Database-22Q1.smi.anon \
--combination_size 3 \
-v \
--timeout 180

echo 'COMPLETE'