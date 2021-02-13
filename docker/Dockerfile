FROM rocker/verse

EXPOSE 8000

RUN installGithub.r andrew-a-hale/fun.with.plumber
ENTRYPOINT R -e "pr <- plumber::plumb_api('fun.with.plumber', 'api_1'); pr_run(pr, host = '0.0.0.0', port=8000)"
