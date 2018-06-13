if [ "$#" -ne 2 ]; then
    echo "Example usage:"
    echo "sh ./add_cron_job.sh ~/my_cache_di 1"
    echo "means 'clear ~/my_cache_di every 1 minute'"
    exit 1;
fi

DIR=$1

if [ "${DIR:0:1}" != "/" ]; then
    DIR="$(pwd)/$1"
fi

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist"
    exit 1;
fi

if ! [[ "$2" =~ ^[1-5][0-9]*$ ]]; then
    echo "Number of minutes must be positive integer between 1 and 59"
    exit 1;
fi

echo "Adding CRON job to clear $DIR every $2 minutes"
JOB="*/$2 * * * * rm $DIR/*"
crontab -l | { cat; echo "$JOB"; } | crontab

echo "CRON job added:"
echo "$JOB"
