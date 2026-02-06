import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["query", "results", "title", "author", "year"];

  async search() {
    const q = this.queryTarget.value.trim();
    if (!q) {
      this.resultsTarget.innerHTML = "<p>Digite um título para buscar.</p>";
      return;
    }

    this.resultsTarget.innerHTML = "<p>Buscando...</p>";

    const resp = await fetch(`/books/search?title=${encodeURIComponent(q)}`, {
      headers: { Accept: "application/json" },
    });

    if (!resp.ok) {
      this.resultsTarget.innerHTML = "<p>Erro ao buscar livros.</p>";
      return;
    }

    const data = await resp.json();
    const results = data.results || [];

    this.renderResults(results);
  }

  renderResults(results) {
    if (results.length === 0) {
      this.resultsTarget.innerHTML = "<p>Nenhum resultado.</p>";
      return;
    }

    const html = results
      .map((r) => {
        const title = this.escape(r.title);
        const author = this.escape(r.author || "Autor desconhecido");
        const year = this.escape(r.year || "");

        return `
          <button
            type="button"
            data-action="click->book-search#select"
            data-title="${title}"
            data-author="${author}"
            data-year="${year}"
            style="display:block; width:100%; text-align:left; margin:8px 0; padding:10px;"
          >
            <strong>${title}</strong><br/>
            <small>${author}${year ? " • " + year : ""}</small>
          </button>
        `;
      })
      .join("");

    this.resultsTarget.innerHTML = html;
  }

  select(event) {
    const btn = event.currentTarget;

    this.titleTarget.value = btn.dataset.title || "";
    this.authorTarget.value = btn.dataset.author || "";
    this.yearTarget.value = btn.dataset.year || "";

    this.resultsTarget.innerHTML = `<p>Selecionado: <strong>${this.escape(
      btn.dataset.title || ""
    )}</strong></p>`;
  }

  escape(value) {
    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#039;");
  }
}
