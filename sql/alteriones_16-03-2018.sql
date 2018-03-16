ALTER TABLE public.cargo_por_persona
  ADD CONSTRAINT cargo_por_persona_idfuente_financiamiento_fkey FOREIGN KEY (idfuente_financiamiento)
      REFERENCES public.fuente_financiamiento (idfuente_financiamiento) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT;

