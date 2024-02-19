# job40
: << USAGE
export JOB_SCRIPT=/data/xchem-fragalysis/shared/singularity.sh;
export APPTAINER_CONTAINER=/data/xchem-fragalysis/mferla/singularity/rocky3.sif;
export APPTAINERENV_CONDA_PREFIX=/data/xchem-fragalysis/mferla/waconda;
export JOB_INNER_SCRIPT=/data/xchem-fragalysis/mferla/ASAP/A71.2/job_fragmenstein.sh

export APPTAINERENV_EXPERIMENT=fullpairs
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-40.novalocal")'

export APPTAINERENV_EXPERIMENT=fragpairs
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-41.novalocal")'

export APPTAINERENV_EXPERIMENT=fulltrio
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-42.novalocal")'

export APPTAINERENV_EXPERIMENT=fragtrio
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-43.novalocal")'

export APPTAINERENV_EXPERIMENT=fix
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-44.novalocal")'

export APPTAINERENV_EXPERIMENT=test
condor_submit /data/xchem-fragalysis/shared/target_script.condor -a 'Requirements=(machine == "orpheus-worker-44.novalocal")'

export APPTAINERENV_EXPERIMENT=hack
for i in {0..502}
do
export APPTAINERENV_EXPERIMENTN=$i
echo "submitting $APPTAINERENV_EXPERIMENTN"
condor_submit /data/xchem-fragalysis/shared/target_script.condor
done
USAGE

export HOST=${HOST:-$(hostname)}
export USER=${USER:-$(users)}
export HOME=${HOME:-$_CONDOR_SCRATCH_DIR}
source /etc/os-release;
echo "Running script ${0} as $USER in $HOST which runs $PRETTY_NAME"
# ---------------------------------------------------------------

source /data/xchem-fragalysis/mferla/.bashrc;
conda activate compchem;
export HOME2=/data/xchem-fragalysis/mferla;
cd $HOME2/ASAP/A71.2;
pwd;

export TEMPLATE='butcher_template.pdb'
export HITS='new_other_hits_fragments.sdf'


N_CORES=$(cat /proc/cpuinfo | grep processor | wc -l)

if [ "$EXPERIMENT" == "fullpairs" ]; then

nice -19 fragmenstein pipeline \
                      --template x0310_apo.pdb \
                      --input clean_hits.sdf \
                      --n_cores $(($N_CORES - 1)) \
                      --suffix _fullpairs \
                      --max_tasks 5000 \
                      --sw_databases REAL-Database-22Q1.smi.anon \
                      --combination_size 2 \
                      --workfolder /data/outerhome/tmp/$EXPERIMENT \
                      --timeout 600;

elif [ "$EXPERIMENT" == "fragpairs" ]; then

nice -19 fragmenstein pipeline \
                      --template x0310_apo.pdb \
                      --input fragments.sdf \
                      --n_cores $(($N_CORES - 1)) \
                      --suffix _fragpairs \
                      --max_tasks 5000 \
                      --sw_databases REAL-Database-22Q1.smi.anon \
                      --combination_size 2 \
                      --workfolder /data/outerhome/tmp/$EXPERIMENT \
                      --timeout 600;

elif [ "$EXPERIMENT" == "fulltrio" ]; then

nice -19 fragmenstein pipeline \
                      --template x0310_apo.pdb \
                      --input clean_hits.sdf \
                      --n_cores $(($N_CORES - 1)) \
                      --suffix _fulltrio \
                      --max_tasks 5000 \
                      --sw_databases REAL-Database-22Q1.smi.anon \
                      --combination_size 3 \
                      --workfolder /data/outerhome/tmp/$EXPERIMENT \
                      --timeout 600;
                      
elif [ "$EXPERIMENT" == "fragtrio" ]; then

nice -19 fragmenstein pipeline \
                      --template x0310_apo.pdb \
                      --input fragments.sdf \
                      --n_cores $(($N_CORES - 1)) \
                      --suffix _fragtrio \
                      --max_tasks 5000 \
                      --sw_databases REAL-Database-22Q1.smi.anon \
                      --combination_size 3 \
                      --workfolder /data/outerhome/tmp/$EXPERIMENT \
                      --timeout 600;

elif [ "$EXPERIMENT" == "fix" ]; then

nice -19 python manual_analogs.py;

elif [ "$EXPERIMENT" == "hack" ]; then

echo "RUNNING $EXPERIMENTN"

python placement_hack.py

fi
echo 'COMPLETE'


curl -X POST -H 'Content-type: application/json' --data '{"text":"'$EXPERIMENT$EXPERIMENTN'"}' $SLACK_WEBHOOK