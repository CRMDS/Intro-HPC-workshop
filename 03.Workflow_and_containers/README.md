# Additional Information: Containers and Workflows

## Overview
This section introduces two critical technologies that have transformed modern HPC: containers for reproducible computing environments and workflow management systems for orchestrating complex computational pipelines.

---

## Part 1: Containers in HPC

### The Problem: Dependency Hell
Every HPC system is different. Your local workstation has Python 3.9, but the cluster only has Python 3.6. You need a specific version of NumPy, but it conflicts with another user's requirements. The specific cuda version you need isn't installed, and you don't have admin rights to install it. Your collaborator's code works perfectly on their system but crashes on yours with cryptic library errors.

This is "dependency hell" - the nightmare of managing software dependencies across different computing environments. Traditional solutions like modules help, but they're limited and system-specific.

### What Are Containers and Why Do They Matter?
Containers package applications with all their dependencies into a portable, lightweight unit that runs consistently across different computing environments.

**Key Benefits for HPC:**
- **Reproducibility**: Your code runs the same way everywhere
- **Dependency Management**: No more "it works on my machine" problems
- **Legacy Software**: Run older software on modern systems
- **Collaboration**: Easy sharing of complete computational environments

### Introduction to Singularity/Apptainer
Singularity (now called Apptainer) is the container platform designed specifically for HPC environments.

**Why Singularity/Apptainer for HPC:**
- Designed for multi-user, shared HPC systems
- No root/sudo privileges required to run containers
- Integrates with HPC schedulers (SLURM, PBS, etc.), or local machines
- Supports GPU access and MPI applications

**Alternative: Docker**
- Easy to use locally, but requires sudo/root privileges, making it unsuitable for HPC use.
- Has a good Online Community sharing many pre-built containers through [Docker Hub](https://hub.docker.com/) 
- Able to convert Docker Containers to Singularity Containers, though can get messy on non-Linux machines (sorry Mac users!)

### Basic Singularity/Apptainer Concepts
- **Images**: Read-only templates containing your application and environment
- **Containers**: Running instances of images
- **Definition Files**: Recipes for building custom images

### Common Use Cases
- Running complex software stacks without installation headaches (once the container is set up, that is)
- Ensuring consistent environments across development and production
- Isolating conflicting dependencies between projects
- Distributing complete computational environments with publications

### Quick Demo/Examples
```bash
# Pull a pre-built container
singularity pull docker://ubuntu:20.04

# Run a command in the container using the exec command
singularity exec ubuntu_20.04.sif cat /etc/os-release

# Run a terminal within the container with the shell command
singularity shell ubuntu_20.04.sif
```

---

## Part 2: Workflow Management

### The Problem: Computational Chaos
You have a complex analysis with 50 steps involving downloading data, pre-processing the data, setting up a ML model, optimising over a bunch of different hyper-parameters, re-training a model using the optimum parameters and datasets, making some predictions, aggregating the results, and outputting wonderful plots. All up, it takes 3 days to run. Step 47 fails at 2 AM, and you have to start over. Your pipeline works great on your laptop, but when you try to run it on the HPC cluster, you need to completely rewrite the job submission scripts, since you're now working on a HPC cluster, and not a laptop you have full admin rights over. You want to run the same analysis on 100 datasets, but manually managing all those jobs is a nightmare. Your workflow uses both containers and bare-metal software, different queue systems from different HPC systems (you might have some jobs running on the WSU HPC, and some running at NCI), and various resource requirements - coordinating all of this manually is error-prone and time-consuming.

This is computational chaos - the challenge of orchestrating complex, multi-step analyses across different computing environments while managing failures, resources, and dependencies.

### What Are Computational Workflows?
Workflows are automated sequences of computational tasks that process data through multiple steps, managing dependencies, inputs, outputs, and error handling.

**Why Workflows Matter in HPC:**
- **Complexity Management**: Handle multi-step analyses with hundreds of tasks
- **Reproducibility**: Document and repeat entire computational pipelines
- **Portability**: Run the same workflow on laptops, clusters, or cloud platforms
- **Error Recovery**: Resume from failures without starting over (checkpointing)
- **Resource Optimisation**: Right-size compute resources for each task
- **Queue System Abstraction**: Same workflow works with SLURM, PBS, or local execution
- **Container Integration**: Seamlessly mix containerised and native applications
- **Parallel Execution**: Automatically identify and run independent tasks simultaneously

### Introduction to Nextflow
Nextflow is a workflow management system designed for data-intensive computational pipelines, particularly popular in bioinformatics and scientific computing.

**Key Nextflow Features:**
- **Portable**: Runs on laptops, clusters, and cloud platforms
- **Scalable**: Automatically handles parallelisation and resource management
- **Container-Native**: Built-in support for Docker, Singularity/Apptainer
- **Resumable**: Continue workflows from where they left off
- **Language**: Very similar to [Groovy](https://groovy-lang.org/) - a language used mostly for scripting in Java Virtual Machines, though with [some tweaks](https://www.nextflow.io/docs/latest/reference/syntax.html#syntax-page). Bears some similarity to Python

### Workflow Components
- **Processes**: Individual computational tasks
- **Channels**: Data flow between processes
- **Executors**: How tasks are submitted (local, SLURM, PBS, cloud)
- **Configuration**: Resource requirements, container settings

### Real-World Example Scenarios
- **Genomics Pipeline**: Quality control → Alignment → Variant calling → Annotation
- **Image Processing**: Raw data → Preprocessing → Analysis → Visualisation
- **Climate Modeling**: Data ingestion → Model runs → Post-processing → Visualisation
 - **Machine Learning Pipeline**: Data ingestion → Feature engineering → Model training → Hyperparameter tuning → Model evaluation → Deployment

### Integration with HPC Systems
Workflows automatically:
- Submit jobs to any cluster scheduler (SLURM, PBS, etc.)
- Manage resource allocation (CPU, GPU, memory, time)
- Handle job queuing and dependencies
- Restart failed tasks from checkpoints
- Aggregate results from distributed tasks
- Switch between different execution environments without code changes

---

## Bringing It All Together

### The Power Combination: Containers + Workflows
- **Workflows** manage the orchestration and scaling
- **Containers** ensure consistent, reproducible environments
- **HPC systems** provide the computational power

### Getting Started Recommendations
1. **Start Small**: Begin with simple, single-step containers
2. **Use Existing Resources**: Leverage pre-built containers and workflows
3. **Community Resources**: 
   - [nf-core](https://nf-co.re/) (curated Nextflow pipelines)
   - [Singularity Hub/Container Library](https://cloud.sylabs.io/library)
   - [Docker Hub](https://hub.docker.com/)
4. **Documentation**: Both technologies have excellent documentation and active communities

### Best Practices
- Version control your definition files and workflows
- Test locally before running on HPC systems
- Use meaningful names and documentation
- Plan for data management and storage requirements
- Start with community-tested workflows when possible

---

## Questions and Next Steps

**Resources for Continued Learning:**
- [Nextflow Training](nextflow.io/training) 
- [Apptainer Documentation](apptainer.org/docs)
- [nf-core Community](nf-co.re)
- Your Academic Supervisor!

**Hands-on Opportunities:**
- Many HPC centers offer container and workflow training, for example, [NCI](https://opus.nci.org.au/spaces/Help/pages/48497461/NCI+Training+and+Educational+Events)
- Online tutorials and workshops
- Start with your current research workflows and containerise them incrementally